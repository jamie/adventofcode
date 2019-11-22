# guard

class AdventMatcher
  def initialize(glob)
    @glob = glob
  end

  def match(path)
    path = path.to_s
    return nil unless path =~ @glob
    year, lang, _file = path.split('/')
    {
      year: year,
      lang: lang,
      script: path,
      binary: path.split('.')[0]
    }
  end
end

watch(AdventMatcher.new(/.*\.rb/)) do |match|
  puts ">> #{match[:script]}"
  puts `ruby -Ilib/ruby -I#{match[:year]}/#{match[:lang]} #{match[:script]}`
  puts
end

watch(AdventMatcher.new(/.*\.nim/)) do |match|
  puts ">> #{match[:script]}"
  `nim c --hints=off -p=lib/nim -d=release #{match[:script]}`
  puts `#{match[:binary]}`
  puts
end
