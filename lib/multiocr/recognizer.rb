require 'tempfile'

module MultiOCR
  class Recognizer
    attr_accessor :threshold, :lang, :file, :average_confidence, :text, :img
    def initialize(file, threshold = 0.6, lang = "eng")
      @threshold = threshold
      @lang = lang
      @average_confidence = 0
      @text = ""
    end
    
    
    def run
  
      
      puts "Loaded img, #{img.inspect}"
      e = Tesseract::Engine.new {|e|
        e.language  = :eng
      }
      
      local_img = self.img.deskew
      local_img = local_img.trim
      local_img = local_img.blur_image(1)

      local_img = local_img.threshold (@threshold * Magick::QuantumRange)
      
      outfile = Tempfile.new(['ocr', '.jpg'])
      
      local_img.write(outfile.path)
      
      chunks = 0
      confidence_sum = 0.0
      
      image_data = open(outfile.path).read rescue nil
      
      words = e.words_for(image_data)
      raw_text = ""
      words.each {|w| 
        if w.text && w.text.strip.length > 1 && w.confidence > 50
          raw_text = raw_text + " " + w.text.strip 
          chunks = chunks + 1
          
          confidence_sum = confidence_sum + w.confidence
          
        end
      }
      
      @text = raw_text
      
      if chunks > 0
        average_confidence = confidence_sum / chunks 
      else
        average_confidence = 0
      end
      @average_confidence = average_confidence
      puts "Average confidence with threshold #{@threshold} is #{average_confidence}"
      # load tesseract and do the ocr 
    end
  end
  
end