module Keyline
  class Box
    attr_accessor :children, :parent, :paddings, :margins, :position,
      :dimensions, :orientation, :modifications, :type, :pages, :processings,
      :variant, :signature_id

    class << self
      def from_json(data, parent: nil)
        json         = data.is_a?(Hash) ? data.dup : JSON.parse(data)
        children     = json.delete('children') || []

        box          = self.new(json)
        box.parent   = parent
        box.children = children.collect { |child_json| Box.from_json(child_json, parent: box) }

        return box
      end
    end

    def initialize(attributes = {})
      attributes.stringify_keys!

      @id            = SecureRandom.uuid
      @type          = attributes['type']&.dup                || 'page'       # Types are from smallest to biggest: page, fold, mirror-group, sheet, flap, spine
      @paddings      = attributes['paddings']&.dup            || [0, 0, 0, 0] # top, right, bottom, left
      @margins       = attributes['margins']&.dup             || [0, 0, 0, 0] # top, right, bottom, left
      @position      = attributes['position']&.dup            || [0, 0]       # top left corner
      @orientation   = attributes['orientation']              || 0            # Orientation of a box, clockwise, one of 0, 90, 180, 270
      @dimensions    = attributes['dimensions']&.dup          || [0, 0]       # width, height
      @pages         = attributes['pages']&.dup               || [nil, nil]   # page numbers
      @variant       = attributes['variant']&.dup             || nil          # The variant (i.e. language) of the box
      @modifications = attributes['modifications']&.dup       || []           # Holds information about user made changes
      @processings   = attributes['processings']&.dup         || {}           # Additional data, like folding schemes etc...
      @signature_id  = attributes['signature_id']             || nil          # The ID of the signature this mup represents
      @children      = (attributes['children'] || []).collect { |c| c.dup }   # No children initially
      @parent        = attributes['parent']    || nil                         # No parent initially
    end

    def dup(attributes = {})
      attributes.stringify_keys!

      Box.new(
        type:           attributes['type']          || @type,
        pages:          attributes['pages']         || @pages,
        variant:        attributes['variant']       || @variant,
        position:       attributes['position']      || @position,
        orientation:    attributes['orientation']   || @orientation,
        dimensions:     attributes['dimensions']    || @dimensions,
        paddings:       attributes['paddings']      || @paddings,
        margins:        attributes['margins']       || @margins,
        modifications:  attributes['modifications'] || @modifications,
        processings:    attributes['processings']   || @processings,
        signature_id:   attributes['signature_id']  || @signature_id,
        children:       attributes['children']      || @children,
        parent:         attributes['parent']        || @parent)
    end

    def <=> other_box
      self.area <=> other_box.area
    end

    def top
      @position.first
    end

    def left
      @position.last
    end

    def width
      @dimensions.first
    end

    def height
      @dimensions.last
    end

    def absolute_top
      !@parent || @parent.type == 'sheet' ? self.top : self.top + @parent.absolute_top
    end

    def absolute_left
      !@parent || @parent.type == 'sheet' ? self.left : self.left + @parent.absolute_left
    end

    def absolute_position
      [self.absolute_top, self.absolute_left]
    end

    # Returns width including left and right margins
    def width_with_margins
      @margins[3] + @dimensions[0] + @margins[1]
    end

    # Returns the height including top and bottom margins
    def height_with_margins
      @margins[0] + @dimensions[1] + @margins[2]
    end

    # Returns width and height with their respective margins
    def dimensions_with_margins
      [width_with_margins, height_with_margins]
    end

    # Returns the area needed for the box
    def area
      @dimensions.inject(:*)
    end

    def folding_pattern
      return nil unless @processings.has_key?('folding')
      @processings['folding']
    end

    def cuts
      cuts = @processings.has_key?('cuts') ? @processings['cuts'] : []
      cuts.concat(@children.collect(&:cuts)).flatten
    end

    # Returns true if the sheet already has a cut with a given starting, ending and angle
    # Otherwise false is returned
    def has_cut?(cut)
      return false unless @processings.has_key?('cuts')

      @processings['cuts'].select do |c|
        c['starting'] == cut['starting'] &&
        c['ending']   == cut['ending']
      end.any?
    end

    # Adds a cut through the entire sheet. All coordinations are automatically
    # computed with the given orientation. The starting parameter is either the
    # width (for vertical) or height (for horizontal) at which the cut starts
    def add_cut_through(starting:, orientation:)
      cut = {
        'starting' => orientation == :horizontal ? [starting, 0] : [0, starting],
        'ending'   => orientation == :horizontal ? [starting, self.width] : [self.height, starting]
      }

      return false if self.has_cut?(cut)

      @processings.has_key?('cuts') ? @processings['cuts'] << cut : @processings['cuts'] = [cut]
      return cut
    end

    def add_cut_markers
      # Rebuild the parent/children tree to make sure
      # all absolute positions are correct
      rebuild_tree

      # Get all entities from the sheet that we need to
      # cut around. For standalone pages these are the pages
      # for folded sheets these are the folds
      if entities_to_cut = self.retrieve_boxes(type: 'fold') and entities_to_cut.empty?
        entities_to_cut = self.retrieve_boxes(type: 'page')
      end

      entities_to_cut.each do |entity_to_cut|
        # Add horizontal cuts (left and right)
        self.add_cut_through(starting: entity_to_cut.absolute_top, orientation: :horizontal) if entity_to_cut.absolute_top != 0
        self.add_cut_through(starting: entity_to_cut.absolute_top + entity_to_cut.height_with_margins, orientation: :horizontal) if entity_to_cut.absolute_top + entity_to_cut.height_with_margins < self.height

        # Vertical cuts first (top and bottom)
        self.add_cut_through(starting: entity_to_cut.absolute_left, orientation: :vertical) if entity_to_cut.absolute_left != 0
        self.add_cut_through(starting: entity_to_cut.absolute_left + entity_to_cut.width_with_margins, orientation: :vertical) if entity_to_cut.absolute_left + entity_to_cut.width_with_margins < self.width
      end
    end

    # Returns the width minus left and right paddings
    def available_width_for_children
      self.width - @paddings[1] - @paddings[3]
    end

    # Returns the height minus top and bottom paddings
    def available_height_for_children
      self.height - @paddings[0] - @paddings[2]
    end

    # Returns the center of the box as a coordinate pair. The first coordinate
    # is top, the second is left
    def center
      [@position[0] + @dimensions[1] / 2, @position[1] + @dimensions[0] / 2]
    end

    def move!(to:)
      self.position = [self.position[0] += to[0], self.position[1] += to[1]]
    end

    # Returns a new box with flipped height and width
    # This is equivalent to a deep_dup, it also rotates
    # all children inside the box
    def rotate
      rotated_box = self.dup
      rotated_box.rotate!
      return rotated_box
    end

    # Flips the width and height of the current box, equivalent
    # to a 90 degree clockwise turn. If flip position is set the
    # position will also be flipped, which is required for children
    # inside a parent
    def rotate!(degrees: 90, center_top: nil, center_left: nil)
      # Make sure only the correct rotations are run
      unless [-360, -270, -180, -90, 0, 90, 180, 270, 360].include?(degrees)
        raise ArgumentError, "invalid rotation of #{degrees} degrees. Only 90, 180, 270, 360, and 0 (positive and negative) are allowed."
      end

      # Find the center of the box
      center_top, center_left = self.center unless center_left && center_top

      # Store previous position
      top_was, left_was = self.position

      # Set the rotation after the rotate
      self.dimensions.reverse! if (degrees % 180) > 0
      self.orientation = case self.orientation + degrees
      when -1000..-1  then self.orientation + degrees + 360
      when 0..359     then self.orientation + degrees
      when 360..1000  then self.orientation + degrees - 360
      end

      # Move all marigns and paddings clockwise
      @paddings = [@paddings.slice!(3), @paddings].flatten
      @margins  = [@margins.slice!(3), @margins].flatten

      # Rotate the box
      case degrees
      when 0, -360, 360
        # do nothing

      when 90, -270
        self.position[1], self.position[0] = -self.position[0] + center_top - width + center_left, self.position[1] - center_left + center_top

      when -180, 180
        self.position[1], self.position[0] = -self.position[1] + center_left * 2 - width, - self.position[0] + center_top * 2 - height

      when -90, 270
        self.position[1], self.position[0] = self.position[0] - center_top + center_left, -self.position[1] + center_left + center_top - height
      end

      # Move and rotate all children
      children.each { |c| c.move!(to: [top_was - position[0], left_was - position[1]]) }
      children.each { |c| c.rotate!(degrees: degrees, center_top: height / 2, center_left: width / 2) }
    end

    # Returns the number of boxes of the given configuration that
    # would fit inside this box
    def amount_of_fitting_children(box)
      (self.available_height_for_children / box.height_with_margins) * (self.available_width_for_children / box.width_with_margins)
    rescue ZeroDivisionError
      return 0
    end

    # Fills the box with the repetitions of the signature that was
    # provided. Might rotate the signature 90 degress if that allows
    # more to fit in and also centeres the filled boxes at the end
    def fill_with_signature(signature:, maximum_repeats: nil)
      fill_with_signatures(signatures: [signature], maximum_number_of_signatures: maximum_repeats)
    end

    # Fills the box with the signatures provided. All provided signatures must have
    # the same size, there are no optimisations carried out and different sized signatures
    # will lead to unpredicted results. Might rotate the signature 90 degress if that allows
    # more to fit in. If all signatures have been imposed at least once and there is still space
    # the signature array will be imposed again from the beginning, leading in the same signatures
    # possibly being placed more than once. After placement is done all boxes will be centered
    def fill_with_signatures(signatures:, maximum_number_of_signatures: nil)
      signatures = signatures.dup
      prototype  = signatures.first.box

      # Check which orientation is better and rotate all signatures if
      # that makes sense
      if self.amount_of_fitting_children(prototype.rotate) > self.amount_of_fitting_children(prototype)
        signatures.each { |s| s.box.rotate! }
      end

      # Set the base variables
      top_cursor            = 0
      number_of_lines       = 0
      boxes_in_last_line    = 0
      page_cursor           = 0
      used_signatures       = Array.new
      available_height      = available_height_for_children
      available_width       = available_width_for_children
      least_available_width = available_width

      catch :maximum_signatures_reached do
        while available_height >= prototype.height_with_margins do
          available_width  = available_width_for_children
          left_cursor      = 0
          boxes_per_line   = 0

          while available_width >= prototype.width_with_margins do
            # If all signatures have been placed once we
            # place all of them a second time as long as
            # there is space
            if signatures.empty?
              signatures = used_signatures
              used_signatures = Array.new
            end

            current_signature = signatures.shift
            used_signatures << current_signature

            child          = current_signature.box.dup
            child.position = [top_cursor + @paddings[0], left_cursor + @paddings[3]]

            self.children << child
            child.parent   = self

            available_width  -= prototype.width_with_margins
            left_cursor      += prototype.width_with_margins
            page_cursor      += 2
            boxes_per_line   += 1

            # If there is a maximum number of signatures that should be
            # put on a single sheet the loop will be broken if that limit
            # is reached
            if maximum_number_of_signatures && children.size >= maximum_number_of_signatures
              least_available_width = available_width if available_width < least_available_width
              available_height     -= prototype.height_with_margins
              throw :maximum_signatures_reached
            end
          end

          least_available_width = available_width if available_width < least_available_width
          available_height     -= prototype.height_with_margins
          top_cursor           += prototype.height_with_margins
          number_of_lines      += 1
          boxes_in_last_line    = boxes_per_line
        end
      end

      # Set the centering offsets if centering is desired
      horizontal_offset = least_available_width / 2
      vertical_offset   = available_height / 2

      children.each { |c| c.position = [c.position.first + vertical_offset, c.position.last + horizontal_offset] }

      return self
    end

    # Returns true if the box has no children,
    # false otherwise
    def empty?
      @children.empty?
    end

    def retrieve_boxes(type: 'page')
      boxes  = @type == type ? [self] : []
      boxes.concat(@children.collect { |c| c.retrieve_boxes(type: type) }).flatten
    end

    # Returns the number of mups this box or it's
    # children contain
    def number_of_boxes(type: 'page')
      # Mup is a magic type that is either a fold
      # or a page that is not inside a fold
      if type == 'mup'
        amount = (@type == 'fold' || (@type == 'page' && @parent&.type != 'fold' && @parent&.type != 'open_format_area')) ? 1 : 0
      else
        amount = @type == type ? 1 : 0
      end

      amount += @children.collect { |c| c.number_of_boxes(type: type) }.sum
    end

    # Returns the number of folds that are used in the given folding pattern, if there is no
    # pattern, no the pattern has no further information 0 will be returned
    def number_of_folds
      amount  = @processings.has_key?('folding') ? self.folding_pattern.folds : 0
      amount += @children.collect(&:number_of_folds).sum
    end

    # Returns the number of unique folds inside this box. So if the box contains the same
    # folding pattern twice, only one will be counted. The folding patterns are compared
    # using their fingerprints, see StockFoldingPattern#fingerprint for details
    def numbers_of_unique_folds(patterns = {})
      if @processings.has_key?('folding')
        pattern = StockFoldingPattern.new(@processings['folding'])

        unless patterns.has_key?(pattern.fingerprint)
          patterns[pattern.fingerprint] = pattern.folds
        end
      end

      @children.each { |b| b.numbers_of_unique_folds(patterns) }
      return patterns
    end

    # Returns the number of unique pages that are on a sheet. If page number 6/7
    # is six times on this sheet then the result would be 2
    def number_of_unique_pages
      @children.collect { |c| c.retrieve_page_numbers(c) }.flatten.uniq.size
    end

    def retrieve_page_numbers(box = self)
      (box.type != 'page' ? box.children.collect { |c| retrieve_page_numbers(c) } : box.pages).flatten
    end

    # Recursively returns the signature ID of this box and it's children
    # if it or it's children are either a fold or a page
    def retrieve_signature_ids
      (%w( page fold ).include?(@type) ? [@signature_id] : []).concat(@children.collect { |c| c.retrieve_signature_ids }).flatten.compact
    end

    # Returns the amount of times the same page is repeated inside this box. This does
    # return a hash allowing you to see how many times a single page was repeated
    def repeats_of_same_page
      @children.collect { |c| c.retrieve_page_numbers(c) }.flatten.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total }
    end

    # Returns true if the current box is of the same layout and has the same
    # amount and orientation of children than box. Page numbers and variants
    # are ignored
    def similar?(box)
      @dimensions     == box.dimensions    &&
      @orientation    == box.orientation   &&
      @paddings       == box.paddings      &&
      @margins        == box.margins       &&
      @type           == box.type          &&
      @children.size  == box.children.size &&

      # We need to check if all children similarities queries return
      # true, and we don't want it to be true if all elements are false
      # which the all? method would give us, so we have to add one true
      # element in the beginning of the array to prevent this
      [true].concat(@children.collect.with_index { |c, index| c.similar?(box.children[index]) }).all?
    end

    # Returns a serializable hash representation of
    # this box object, recursively including all children
    def as_json(options = nil)
      {
        'id'            => @id,
        'signature_id'  => @signature_id,
        'children'      => @children.collect { |child| child.as_json },
        'paddings'      => @paddings,
        'margins'       => @margins,
        'position'      => @position,
        'orientation'   => @orientation,
        'dimensions'    => @dimensions,
        'modifications' => @modifications,
        'type'          => @type,
        'pages'         => @pages,
        'variant'       => @variant,
        'processings'   => @processings
      }
    end

  private
    # Recursivley rebuilds the parent/children tree
    def rebuild_tree
      self.children.each do |child|
        child.parent = self
        child.send(:rebuild_tree)
      end
    end
  end
end
