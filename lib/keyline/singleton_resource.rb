module Keyline
  module SingletonResource
    include Keyline::Resource

    def path
      Array.new.tap do |segments|
        segments << @parent.path if @parent && !self.class.path_prefix
        segments << self.class.path_prefix if self.class.path_prefix
        segments << self.name_in_path
      end.join('/')
    end

    def name_in_path
      self.class.to_s.demodulize.underscore
    end

    alias_method :path_for_show,    :path
    alias_method :path_for_create,  :path
    alias_method :path_for_update,  :path
    alias_method :path_for_destroy, :path
  end
end
