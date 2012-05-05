module Eyepaste
  module Mail
    class Interceptor
      @@white_list = nil

      def self.set_white_list(regexp_or_array=nil, &block)
        if block
          @@white_list = block
        else
          if regexp_or_array.kind_of?(Regexp)
            @@white_list = [regexp_or_array]
          elsif regexp_or_array.respond_to?(:each)
            @@white_list = regexp_or_array
          end
        end
      end

      def self.get_white_list
        if @@white_list.kind_of?(Proc)
          @@white_list.call
        else
          @@white_list
        end
      end
    end
  end
end
