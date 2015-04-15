require "nlp_arabic/version"
require "nlp_arabic/characters"

module NlpArabic
  def self.stem(word)
    # Step 1: remove non alphanumeric characters    
      word = clean(word)
    # Step 2: remove diacritics
      word = remove_diacritics(word)
    # Step 3: normalize hamza, ouaou and yeh to bare alif
      word = normalize_hamzaas(word)
    # Step 4: remove prefix of size 3 then 2
      word = remove_prefix(word)
    # Step 5: remove suffix of size 3 then 2
      word = remove_suffix(word)
    # Step 6: remove the connective waw
      word = remove_waw(word)
    # Step 7: convert inital alif (optional)
      word = convert_initial_alef(word)
    # Step 8: 
    if word.length == 4
      word = word_4(word)
    elsif word.length == 5
      word = pattern_53(word)
      word = word_5(word)
    elsif word.length == 6
      word = pattern_6(word)
      word = word_6(word)
    elsif word.length == 7
      word = short_suffix(word)
      word = short_prefix(word) if word.length == 7
      if word.length == 6
        word = pattern_6(word)
        word = word_6(word)
      end
    end
    return word
  end

  def self.stem_text(text)
    # remove words from the stop list
    # clean_text = (text.split - NlpArabic::STOP_LIST)
    clean_text = text.split
    for i in (0..(clean_text.length-1))
      clean_text[i]= stem(clean_text[i])
    end
    return clean_text.join(' ')
  end

  def self.clean(word)
    return word.strip.gsub(/[._,،\"\':;&?؟()]/, '')
  end

  def self.remove_diacritics(word)
    # removes arabic diacritics (fathatan, dammatan, kasratan, fatha, damma, kasra, shadda, sukun) and tateel
    return word.gsub(/#{NlpArabic::DIACRITICS}/, '')
  end

  def self.convert_initial_alef(word)
    return word.gsub(/#{NlpArabic::ALIFS}/, NlpArabic::ALEF)
  end

  def self.normalize_hamzaas(word)
    return word.gsub(/#{NlpArabic::HAMZAAS}/, NlpArabic::ALEF)    
  end

  def self.remove_prefix(word)
    if word.length >= 6
      return word[3..-1] if word.start_with?(*NlpArabic::P3) 
    end
    if word.length >= 5
      return word[2..-1] if word.start_with?(*NlpArabic::P2)
    end
    return word
  end

  def self.remove_suffix(word)
    if word.length >= 6
      return word[0..-4] if word.end_with?(*NlpArabic::S3)
    end
    if word.length >= 5
      return word[0..-3] if word.end_with?(*NlpArabic::S2) 
    end
    return word
  end

  def self.remove_waw(word)
    if word.length >= 4
      return word[1..-1] if word.start_with?(*NlpArabic::DOUBLE_WAW)
    end
    return word
  end

  def self.word_4(word)
    if NlpArabic::PR4[0].include? word[0] 
      return word[1..-1]
    elsif NlpArabic::PR4[1].include? word[1]
      word[1] = ''
    elsif NlpArabic::PR4[2].include? word[2]
      word[2] = ''
    elsif NlpArabic::PR4[3].include? word[3]
      word[3] = ''
    else 
      word = short_suffix(word)
      word = short_prefix(word) if word.length == 4
    end
    return word
  end

  def self.word_5(word)
    if word.length == 4
      word = word_4(word)
    elsif word.length == 5
      word = pattern_54(word)
    end
    return word
  end

  def self.pattern_53(word)
    if NlpArabic::PR53[0].include? word[2] && word[0] ==  NlpArabic::ALEF
      word = word[1] + word[3..-1]
    elsif NlpArabic::PR53[1].include? word[3] && word[0] ==  NlpArabic::MEEM
      word = word[1..2] + word[4]
    elsif NlpArabic::PR53[2].include? word[0] && word[4] ==  NlpArabic::TEH_MARBUTA
      word = word[1..3]
    elsif NlpArabic::PR53[3].include? word[0] && word[2] ==  NlpArabic::TEH
      word = word[1] + word[3..-1]
    elsif NlpArabic::PR53[4].include? word[0] && word[2] ==  NlpArabic::ALEF
      word = word[1] + word[3..-1]
    elsif NlpArabic::PR53[5].include? word[2] && word[4] ==  NlpArabic::TEH_MARBUTA
      word = word[0..1] + word[3]
    elsif NlpArabic::PR53[6].include? word[0] && word[1] ==  NlpArabic::NOON
      word = word[2..-1]
    elsif word[3] ==  NlpArabic::ALEF && word[0] ==  NlpArabic::ALEF
      word = word[1..2] + word[4]
    elsif word[4] ==  NlpArabic::NOON && word[3] ==  NlpArabic::ALEF
      word = word[0..2]
    elsif word[3] ==  NlpArabic::YEH && word[0] ==  NlpArabic::TEH
      word = word[1..3] + word[4]
    elsif word[3] ==  NlpArabic::WAW && word[0] ==  NlpArabic::ALEF
      word = word[0] + word[2] + word[4]
    elsif word[2] ==  NlpArabic::ALEF && word[1] ==  NlpArabic::WAW
      word = word[0] + word[3..-1]
    elsif word[3] ==  NlpArabic::YEH_WITH_HAMZA_ABOVE && word[2] ==  NlpArabic::ALEF
      word = word[0..1] + word[4]
    elsif word[4] ==  NlpArabic::TEH_MARBUTA && word[1] ==  NlpArabic::ALEF
      word = word[0] + word[2..3]
    elsif word[4] ==  NlpArabic::YEH && word[2] ==  NlpArabic::ALEF
      word = word[0..1] + word[3]
    else
      word = short_suffix(word)
      word = short_prefix(word)if word.length == 5
    end
    return word
  end

  def self.pattern_54(word)
    if NlpArabic::PR53[2].include? word[0] 
      word = word[1..-1]
    elsif word[4] == NlpArabic::TEH_MARBUTA
      word = word[0..3]
    elsif word[2] == NlpArabic::ALEF
      word = word[0..1] + word[3..-1]
    end
    return word   
  end

  def self.word_6(word)
    if word.length == 5
      word = pattern_53(word)
      word = word_5(word)
    elsif word.length == 6
      word = pattern_64(word)
    end
    return word
  end

  def self.pattern_6(word)
    if word.start_with?(*NlpArabic::IST) || word.start_with?(*NlpArabic::MST)
      word = word[3..-1]
    elsif word[0] == NlpArabic::MEEM && word[3] == NlpArabic::ALEF && word[5] == NlpArabic::TEH_MARBUTA 
      word = word[1..2] + word[4]
    elsif word[0] == NlpArabic::ALEF && word[2] == NlpArabic::TEH && word[4] == NlpArabic::ALEF 
      word = word[1] + word[3] + word[5]
    elsif word[0] == NlpArabic::ALEF && word[3] == NlpArabic::WAW && word[2] == word[4]
      word = word[1] + word[4..-1]
    elsif word[0] == NlpArabic::TEH && word[2] == NlpArabic::ALEF && word[4] ==  NlpArabic::YEH
      word = word[1] + word[3] + word[5]
    else
      word = short_suffix(word)
      word = short_prefix(word) if word.length == 6
    end
    return word
  end

  def self.pattern_64(word)
    if word[0] == NlpArabic::ALEF && word[4] == NlpArabic::ALEF
      word = word[1..3] + word[5]
    elsif 
      word = word[2..-1]
    end 
    return word 
  end

  def self.short_prefix(word)
    word[1..-1] if word.start_with?(*NlpArabic::P1)
    return word
  end

  def self.short_suffix(word)
    word[0..-2] if word.end_with?(*NlpArabic::S1)
    return word
  end
end