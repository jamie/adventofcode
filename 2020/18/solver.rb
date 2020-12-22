require "advent"
input = Advent.input

def tokenize(string)
    string.
      scan(/\d+|[()+*-]/).
      map{|tok| tok =~ /\d+/ ? tok.to_i : tok }
end

def parse_number(tokens)
    if tokens.first.is_a? Integer
        tokens.shift
    elsif tokens.first == "("
        tokens.shift # "("
        parse(tokens)
    end
end

# Part 1

def parse(tokens)
    total = parse_number(tokens)
    
    while tokens.any?
        op = tokens.shift
        break if op == ")"

        value = parse_number(tokens)
        
        case op
        when '+'
            total += value
        when '*'
            total *= value
        end
    end
    
    total
end

puts input.map{|line| parse(tokenize(line)) }.sum

# Part 2

def parse(tokens) # Method override
    values = [parse_number(tokens)]
    
    while tokens.any?
        op = tokens.shift
        break if op == ")"

        value = parse_number(tokens)
        
        case op
        when '+'
            values[-1] = values[-1] + value
        when '*'
            values << value
        end
    end
    
    values.inject(&:*)
end

puts input.map{|line| parse(tokenize(line)) }.sum