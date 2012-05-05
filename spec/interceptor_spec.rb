require 'spec_helper'
require 'mail'

describe Eyepaste::Mail::Interceptor do
  after(:each) do
    # clear the white list after each test
    Eyepaste::Mail::Interceptor.set_white_list(nil)
  end

  describe ".set_white_list" do
    context "when regexp passed" do
      it "sets the white_list to an array with the regexp as only element" do
        Eyepaste::Mail::Interceptor.set_white_list(/.+?@testdomain\.com/)
        Eyepaste::Mail::Interceptor.get_white_list.should == [/.+?@testdomain\.com/]
      end
    end

    context "when array of regexps passed" do
      it "sets the white_list to the array" do
        Eyepaste::Mail::Interceptor.set_white_list([/.+?@testdomain\.com/])
        Eyepaste::Mail::Interceptor.get_white_list.should == [/.+?@testdomain\.com/]
      end
    end

    context "when block passed" do
      context "when block returns a regexp" do
        it "return value of proc is wrapped in an array" do
          Eyepaste::Mail::Interceptor.set_white_list do
            /white list proc/
          end
          Eyepaste::Mail::Interceptor.get_white_list.should == [/white list proc/]
        end
      end

      context "when block returns an array" do
        it "return value of proc is an array" do
          Eyepaste::Mail::Interceptor.set_white_list do
            [/white list proc/]
          end
          Eyepaste::Mail::Interceptor.get_white_list.should == [/white list proc/]
        end
      end
    end
  end

  describe ".delivering_mail" do
    context "when single to address" do
      before(:each) do
        @message = Mail.new do
          to  'Hallow World <hallowworld@example.com>'
        end
      end

      context "when address matches white_list" do
        before(:each) do
          Eyepaste::Mail::Interceptor.set_white_list(/.+?@example\.com/)
        end

        it "does not alter the to address" do
          expect {
            Eyepaste::Mail::Interceptor.delivering_email(@message)
          }.to_not change(@message[:to], :to_s)
        end

        it "retains the formatted To: header" do
          Eyepaste::Mail::Interceptor.delivering_email(@message)
          @message[:to].to_s.should == 'Hallow World <hallowworld@example.com>'
        end
      end

      context "when address does not match white_list" do
        it "alters the to address" do
          expect {
            Eyepaste::Mail::Interceptor.delivering_email(@message)
          }.to change(@message[:to], :to_s)
        end

        it "munges the to address to an eyepaste email" do
          Eyepaste::Mail::Interceptor.delivering_email(@message)
          @message[:to].addresses.first.should == 'hallowworld_example.com@eyepaste.com'
        end

        it "retains the formatted To: header" do
          Eyepaste::Mail::Interceptor.delivering_email(@message)
          @message[:to].to_s.should == 'Hallow World <hallowworld_example.com@eyepaste.com>'
        end
      end
    end

    context "when multiple to addresses" do
      before(:each) do
        Eyepaste::Mail::Interceptor.set_white_list(/.+?@example\.com/)
        @message = Mail.new do
          to  'Hallow World <hallowworld@example.com>, flatearth@domain.com'
        end
      end

      it "alters the to addresses that don't match the white list" do
        Eyepaste::Mail::Interceptor.delivering_email(@message)
        @message[:to].addresses.should == ['hallowworld@example.com', 'flatearth_domain.com@eyepaste.com']
      end

      it "retains the formatted To: header" do
        Eyepaste::Mail::Interceptor.delivering_email(@message)
        @message[:to].to_s.should == 'Hallow World <hallowworld@example.com>, flatearth_domain.com@eyepaste.com'
      end
    end
  end
end
