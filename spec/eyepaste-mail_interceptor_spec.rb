require 'spec_helper'

describe Eyepaste::Mail::Interceptor do
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
      it "sets the white list to the proc, calls on get" do
        Eyepaste::Mail::Interceptor.set_white_list do
          /white list proc/
        end
        Eyepaste::Mail::Interceptor.get_white_list.should == /white list proc/
      end
    end
  end

  describe ".delivering_mail" do
  end
end
