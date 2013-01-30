require 'optparse'

module FindOptionParser
  # Make it singeltone
  extend self
  #
  # Return a structure describing the options.
  #
  def parse(args)
    # The options specified on the command line will be collected in *options*.
    # We set default values here.
    options = {}

    opts = OptionParser.new do |opts|
      opts.banner = "Usage: find.rb DIRECTORY [OPTS]"

      opts.separator ""
      opts.separator "Specific options:"

      opts.on("--name ARG", 
        "Predicate matches if browsed file name matches.") do |name|
        options[:name] = Regexp.new('\A' + name + '\z')
      end

      opts.on("--type [TYPE]", [:f, :d, :l, :s], 
        "Predicate matches if browsed file is of desired type.", "(f - file, d - directory, l - symbolic link, s - socket)") do |type|
        options[:type] = case type
        when :f
          "file"
        when :d
          "directory"
        when :l
          "link"
        when :s
          "socket"
        end 
      end

      opts.on("--cnewer PATH", 
        "Predicate matches if browsed file is newer than the file at PATH.") do |path| 
        options[:cnewer] = path
      end

      opts.on("--user UNAME", 
        "Predicate matches if browsed file is owned by UNAME.") do |uname| 
        options[:uname] = uname
      end

      opts.on("--maxdepth N", OptionParser::DecimalInteger, 
        "Do no go deeper than N subdirectories while crawling DIRECTORY.") do |n| 
        options[:maxdepth] = n.to_i
      end

      opts.separator ""
      opts.separator "Common options:"

      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end

    end

    opts.parse!(args)
    options
  end

end