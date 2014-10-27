require 'tempfile'

module MultiOCR
  class Recognizer
    attr_accessor :threshold, :lang, :file, :average_confidence, :text
    def initialize(file, threshold = 0.6, lang = "eng")
      @threshold = threshold
      @lang = lang
      @average_confidence = 0
      @file = file
      @text = ""
    end
    
    
    def run
      img = Magick::ImageList.new(@file)
      
      puts "Loaded img."
      e = Tesseract::Engine.new {|e|
        e.language  = :eng
      }
      img = img.deskew
      img = img.despeckle
      img = img.trim
      
      img = img.threshold (@threshold * Magick::QuantumRange)
      
      outfile = Tempfile.new(['ocr', '.jpg'])
      
      img.write(outfile.path)
      
      chunks = 0
      confidence_sum = 0.0
      
      image_data = open(outfile.path).read rescue nil
      
      words = e.words_for(image_data)
      raw_text = ""
      words.each {|w| 
        if w.text && w.text.strip.length > 1
          raw_text = raw_text + " " + w.text.strip 
          chunks = chunks + 1
          
          confidence_sum = confidence_sum + w.confidence
          
        end
      }
      
      @text = raw_text
      
      
      average_confidence = confidence_sum / chunks
      @average_confidence = average_confidence
      puts "Average confidence with threshold #{@threshold} is #{average_confidence}"
      # load tesseract and do the ocr 
    end
  end
  
end