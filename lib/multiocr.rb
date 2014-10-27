require 'bundler'
require 'RMagick'
require 'tesseract-ocr'

module MultiOCR
  class OCR
    def recognize(filename)
      best_confidence = 0
      text = ""
      1.upto(10) do |t|
        r = Recognizer.new(filename, (2.5 + (t/2.0)) * 0.1)
        
        r.run
        
        if (r.average_confidence > best_confidence)
          text = r.text
          best_confidence = r.average_confidence
        elsif (best_confidence > 0 && r.average_confidence < best_confidence)
          break
        end
        
      end
      
      puts text
      
    end
  end
    
end

require 'multiocr/recognizer.rb'