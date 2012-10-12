require 'spec_helper'

describe Document do

  it "icon_class should be 'img'" do
    document = FactoryGirl.create(:img_document)
    document.icon_extension.should eq("img")
  end

  it "icon_class should be 'xls'" do
    document = FactoryGirl.create(:xls_document)
    document.icon_extension.should eq("xls")
  end

  it "icon_class should be 'doc'" do
    document = FactoryGirl.create(:doc_document)
    document.icon_extension.should eq("doc")
  end

  it "icon_class should be 'pdf'" do
    document = FactoryGirl.create(:pdf_document)
    document.icon_extension.should eq("pdf")
  end

  it "icon_class should be 'img'" do
    document = FactoryGirl.create(:mul_document)
    document.icon_extension.should eq("mul")
  end

end