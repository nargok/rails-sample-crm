require 'nkf'

module StringNormalizer extend ActiveSupport::Concern

    def normalize_as_name(text)
      # -w : UTF-8で出力する -Z1 : 全角の英数字、記号、全角スペースを半角に変える
      # stript : 文字列の先頭と末尾にある空白文字を削除する
      NKF.nkf('-W -w -Z1', text).strip if text
    end

    def normalize_as_furigana(text)
      # --katakana : ひらがなをカタカナに変える
      NKF.nkf('-W -w -Z1 --katakana', text).strip if text
    end

    def normalize_as_postal_code(text)
      # 全角文字を半角文字に変換して、マイナス記号を取り除く
      NKF.nkf('-W -w -Z1', text).strip.gsub(/-/, '') if text
    end

    def normalize_as_email(text)
      NKF.nkf('-W -w -Z1', text).strip if text
    end

end
