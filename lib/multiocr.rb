require 'bundler'
require 'RMagick'
require 'tesseract-ocr'

module MultiOCR
  class OCR
    attr_accessor :text
    def recognize(filename)
      best_confidence = 0
      text = ""
      accepted_decline = 2
      1.upto(10) do |t|
        r = Recognizer.new(filename, (2.5 + (t/2.0)) * 0.1)
        
        r.run
        
        if (r.average_confidence > best_confidence)
          text = r.text
          best_confidence = r.average_confidence 
        elsif (best_confidence > 0 && r.average_confidence < best_confidence)
          accepted_decline=  accepted_decline - 1 
          
          break if accepted_decline = 0
        end
        
      end
      
      @text = text
      
    end
  end
    
end

require 'multiocr/recognizer.rb'