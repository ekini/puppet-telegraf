def dumpvar(var)
  case var
    when String
        "'#{var}'"
    when Array
        "[#{var.map { |x| dumpvar(x) }.join(", ")}]"
    else
        var.to_s
  end
end

module Puppet::Parser::Functions
  newfunction(:dump_var, :type => :rvalue) do |args|
    dumpvar(args[0])
  end
end

