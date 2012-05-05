module Eyepaste
  module Mail
    class Interceptor
      @@white_list = nil

      def self.set_white_list(white_list=nil, &block)
        @@white_list = block || white_list
      end

      def self.get_white_list
        return [] if @@white_list.nil?

        white_list = @@white_list.kind_of?(Proc) ? @@white_list.call : @@white_list

        white_list.respond_to?(:each) ? white_list : [white_list]
      end

      def self.delivering_email(message)
        message.to = message[:to].addrs.map do |addr|
          email = addr.address
          on_white_list = get_white_list.any? { |regexp| regexp.match(email)}
          if !on_white_list
            munged_email = "#{email.gsub(/@/, '_')}@eyepaste.com"
            formatted_address = addr.format.gsub(email, munged_email)
          else
            formatted_address = addr.format
          end

          formatted_address
        end
      end
    end
  end
end
