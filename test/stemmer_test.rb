require "test_helper"

class StemmerTest < Test::Unit::TestCase
  def test_removing_na_characters
    assert_equal "تكنولوجيا", NlpArabic.remove_na_characters("تكنولوجيا.?")
    assert_equal "فيسبوك", NlpArabic.remove_na_characters("._,،فيسبوك")
    assert_equal "يوتيوب", NlpArabic.remove_na_characters("\"يوتيوب\'؟(")
    assert_equal "يوتيوب", NlpArabic.remove_na_characters(";&يوتيوب)")
    assert_equal "", NlpArabic.remove_na_characters("&&&")
  end

  def test_diactritics_removal
    assert_equal "م", NlpArabic.remove_diacritics("مَ")
    assert_equal "م", NlpArabic.remove_diacritics("مِ")
    assert_equal "م", NlpArabic.remove_diacritics("مُ")
    assert_equal "ح", NlpArabic.remove_diacritics("حٌ")
    assert_equal "ح", NlpArabic.remove_diacritics("حْ")
    assert_equal "ح", NlpArabic.remove_diacritics("حٍ")
    assert_equal "ح", NlpArabic.remove_diacritics("حً")
  end

  def test_initial_alef
    assert_equal "ا", NlpArabic.convert_initial_alef("إ")
    assert_equal "الف", NlpArabic.convert_initial_alef("ألف")
    assert_equal "ا", NlpArabic.convert_initial_alef("ٱ")
    assert_equal "ا", NlpArabic.convert_initial_alef("آ")
  end

  def test_normalize_hamzaas
    assert_equal "سماا", NlpArabic.normalize_hamzaas("سماء")
    assert_equal "ا", NlpArabic.normalize_hamzaas("ؤ")
    assert_equal "ا", NlpArabic.normalize_hamzaas("ئ")
  end

  def test_prefix_removal
    assert_equal "بيت", NlpArabic.remove_prefix("البيت")
    assert_equal "بيت", NlpArabic.remove_prefix("بيت")
    assert_equal "الرب", NlpArabic.remove_prefix("الرب")
    assert_equal "طلبة", NlpArabic.remove_prefix("الطلبة")
    assert_equal "ضرب", NlpArabic.remove_prefix("الضرب")
    assert_equal "سيف", NlpArabic.remove_prefix("كالسيف")
    assert_equal "سيف", NlpArabic.remove_prefix("والسيف")
    assert_equal "برمجة", NlpArabic.remove_prefix("للبرمجة")
    assert_equal "سيارة", NlpArabic.remove_prefix("بالسيارة")
  end

  def test_text_stemming
    assert_equal "خرع بطر من اليمينيوم يمكن حمل في اقل من دقيق", NlpArabic.stem_text("إختراع بطاريات من الأليمينيوم يمكن تحميلها في أقل من دقيقة")
  end

  def test_is_alphanumeric
    assert_equal true, NlpArabic.is_alpha("بطر")
    assert_equal false, NlpArabic.is_alpha("!!بطر(")
    assert_equal false, NlpArabic.is_alpha(".(")
  end

  def test_clean_text
    assert_equal "آخر الأخبار الدولية منظور أوروبي", NlpArabic.clean_text("آخر الأخبار الدولية من منظور أوروبي")
  end 
end
