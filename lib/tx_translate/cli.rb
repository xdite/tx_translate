require 'thor'
require 'active_support/core_ext/string'
require 'tx_translate'

module TxTranslate
  class CLI < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path('../..', __dir__)
    end

    desc 'config', 'change settings'
    def config
      # 初回起動時に設定ファイルを作成
      config_path = Dir.home + '/.tx_translate'
      if Dir.exist?(config_path)
        puts "Your current name is [#{TxTranslate.config[:name]}]."
      else
        template 'templates/settings.yml.tt', "#{config_path}/settings.yml"
      end
    end

    desc 'word STRING', '翻译句子'
    def word(word, _number = 10)
      if ARGV.length < 2
        puts TxTranslate::TencentFy.new(word).result
      else
        ARGV.delete_at(0)
        str = ARGV.join(' ')
        puts TxTranslate::TencentFy.new(str).result
      end
    end

    desc 'sbv FILENAME', '翻译 sbv 档'
    def sbv(filename)
      TxTranslate::SbvProcess.run(filename)
    end

    desc 'srt FILENAME', '翻译 srt 档'
    def srt(filename)
      TxTranslate::SrtProcess.run(filename)
    end

    desc 'md FILENAME', '翻译 markdown 档'
    def md(filename)
      TxTranslate::MdProcess.run(filename)
    end

    private

    def display_name(name)
      puts name
    end
  end
end
