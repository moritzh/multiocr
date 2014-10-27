require 'spec_helper'

describe MultiOCR::OCR do
  it "should extract the best possible text from a sample" do
    file = "spec/assets/test.jpg"
    ocr = MultiOCR::OCR.new()
    ocr.recognize(file)

    
  end
  
end