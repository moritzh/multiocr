require 'bundler'
require 'RMagick'
require 'tesseract-ocr'

module MultiOCR
  class OCR
    attr_accessor :text
    def recognize(filename)
      best_confidence = 0
      text = ""
      
      img = Magick::ImageList.new(filename) do
        self.density = 300
        puts "Setting density."
      end
      
      img = img[0]
      
      1.upto(6) do |t|
        
        
        
        r = Recognizer.new(filename, (2.5 + t) * 0.1)
        r.img = img
        r.run
        
        if (r.average_confidence > best_confidence)
          text = r.text
          best_confidence = r.average_confidence 
        elsif (best_confidence > 0 && r.average_confidence < best_confidence)

        end
        
      end
      
      @text = text
      
    end
  end
    
end

require 'multiocr/recognizer.rb'