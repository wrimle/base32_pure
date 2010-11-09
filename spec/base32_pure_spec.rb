# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


describe "Base32" do
  include Base32

  context "Crockford" do

    it "encodes a string to base 32" do
      encoded = Base32::Crockford.encode("A")
      encoded.should == "21"
    end

    it "encodes a fixnum to base 32" do
      encoded = Base32::Crockford.encode(12)
      encoded.should == "C9J"
    end

    it "encodes a fixnum the same as the equivalent string" do
      Base32::Crockford.encode(12).should == Base32::Crockford.encode("12")
    end

    it "decodes a string from base 32" do
      string = "21"
      decoded = Base32::Crockford.decode(string)
      decoded.should == "A"
    end

    it "is not case sensitive" do
      string = "21abdevp58"
      decoded_downcase = Base32::Crockford.decode(string)
      decoded_upcase = Base32::Crockford.decode(string.upcase)
      decoded_downcase.should == decoded_upcase
    end


    it "treats 1 and l as the same value" do
      string = "21abdevp58"
      decoded_reference = Base32::Crockford.decode(string)
      decoded_modified = Base32::Crockford.decode(string.tr("1", "l"))
      decoded_reference.should == decoded_modified
    end

    it "treats 1 and I as the same value" do
      string = "21abdevp58"
      decoded_reference = Base32::Crockford.decode(string)
      decoded_modified = Base32::Crockford.decode(string.tr("1", "I"))
      decoded_reference.should == decoded_modified
    end


    it "treats 0 and O as the same value" do
      string = "21ab0devp58"
      decoded_reference = Base32::Crockford.decode(string)
      decoded_modified = Base32::Crockford.decode(string.tr("0", "O"))
      decoded_reference.should == decoded_modified
    end


    it "allows hypenation" do
      string = "21ab0devsdagjølp58"
      string.force_encoding("binary") if string.respond_to?(:force_encoding)
      encoded = Base32::Crockford.hypenate(Base32::Crockford.encode(string))
      decoded = Base32::Crockford.decode(encoded)

      decoded.should == string
    end
  end
end
