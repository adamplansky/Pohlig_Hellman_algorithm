class GF

  
  def initialize(p,m)
    @p = p
    @m = m
  end
  
  def print
    puts "#{@p}^#{@m}"
  end
  
  
  def parse_string_to_poly_base s
    poly_base = Array.new(@m,0)
    ary = s.scan(/x\^\d/)
    ary.each do |x|
      om = x.match(/\d/)
      poly_base[om[0].to_i] = 1
    end
    z_x = s.scan(/(x$|x[^^])/)[0]
    poly_base[1] = 1 if z_x != nil
    z = s.scan(/[^\^]\d{1}/)[0].to_i
    poly_base[0] = z
    poly_base
  end
  
  def add(x,y)
    
    if (x.length != y.length) || (y.length != @m)
      "x.length != y.length"
    else
      xy = Array.new(@m,0)
      for i in 0..x.length-1
        xy[i] = (x[i]^y[i]) 
      end
    end 
    return xy
  end
  
  def multiplication(x,y)
    if (x.length != y.length) || (y.length != @m)
      return "x.length != y.length"
    else
      xy = Array.new(2*@m,0)
      for i in 0..x.length-1
        if(y[i]==0)
          next
        else
          for j in 0..x.length-1
            xy[i+j]=xy[j+i]^x[j]
          end
        end
      end
    end 
    return xy
  end
  def print_poly_from_array s
    # str = "("
#     for i in 0..s.length-2
#         str+="#{s[i]},"
#     end
#     str+="#{s[s.length-1]})"
#     puts str
    puts s.inspect
  end
  
  def print_poly ary
    i = ary.length-1
    str = ""
    newary = Array.new
    while i >= 0 do
      if ary[i] > 0
        mon = case i
              when 0 then "1"
              when 1 then "x"
              else "x^#{i}"
              end
        newary.push(mon)
      end
      i-=1
    end
    puts newary.join(" + ")
  end
  
  def degree(v)
    if v != 0
      result = -1
      while v != 0
        v >>= 1
        result += 1
      end
      return result
    end
    return 0
  end
  
  def binary_mul(lhs, rhs)
    result = 0
    a = [degree(lhs), degree(rhs)].max
    0.upto(a) do |i|
      if lhs & (1 << i) != 0
        result ^= rhs
      end
      rhs <<= 1
    end
    return result
  end
  
  def binary_div(lhs,rhs)
    q = 0
    r = lhs
    p1 = degree(lhs)
    p2 = degree(rhs)
    
    (p1 - p2 + 1).downto(0) do |i|
      puts "i: #{i}, q: #{q}"
      q <<= 1
      puts "po q <<= 1: q: #{q}"
      if r & (1 << (p2+i)) != 0
        q |= 1
        r ^= (rhs << i)
      end
    end
    return [q, r]
  end
  
  def get_bit number, bit
    (number & 1 << bit) > 0 ? 1 : 0
  end

  def binary_double_and_add(_a,_b,_w)
    results = 0
    puts degree(_b)
  (degree(_b)).downto(0) do |i|
      puts "krok #{i}"
      results <<= 1 
      
      if ( get_bit(_b, i) == 1) 
        puts "1. krok iterace:#{i}"
        results ^= _a
        puts "1. krok result: #{results}"
      end
      puts "degree(results) == degree(_w), #{degree(results)}, #{degree(_w)}"
      if degree(results) >= degree(_w)
        results ^= _w
      end
    end
    return results
  end
  
  
  def print_poly_from_number x
    q = 0
    while( x > 0 ) do
      x = x >> 1
      q+=1
    end  
  end
  
  #_p = ireducible polynom
  #_a = hledam inverzi _a
  def EEA _a, _p
    r1 = _p
    r2 = _a
    g1 = 0    
    g2 = 1
    while r2 > 1
      q = binary_div(r1,r2)
      b = g1
      g1 = g2
      g2 = b^binary_double_and_add(g2,q[0],_p)
      
      r1 = r2
      r2 = q[1]
    end
    return g2
  end
  
  def print_poly_from_number x
    newary = Array.new
    degree(x).downto(0) do |i|
      if (get_bit(x,i)) == 1
        mon = case i
              when 0 then "1"
              when 1 then "x"
              else "x^#{i}"
              end
        newary.push(mon)
      end
    end
    puts newary.join(" + ")
  end
  
  # i = ary.length-1
  # str = ""
  # newary = Array.new
  # while i >= 0 do
  #   if ary[i] > 0
  #     mon = case i
  #           when 0 then "1"
  #           when 1 then "x"
  #           else "x^#{i}"
  #           end
  #     newary.push(mon)
  #   end
  #   i-=1
  # end
  # puts newary.join(" + ")
end



teleso = GF.new(2,8)
#teleso.print
g = "x^7+x^5+x^4+x+1"
f = "x^2 + 1"
poly_base_g = teleso.parse_string_to_poly_base(g)
poly_base_f = teleso.parse_string_to_poly_base(f)

teleso.print_poly_from_array poly_base_f
teleso.print_poly_from_array poly_base_g
x = teleso.add(poly_base_g,poly_base_f)
y = teleso.multiplication(poly_base_g,poly_base_f)
puts "----"
teleso.print_poly_from_array x
teleso.print_poly_from_array y
puts teleso.print_poly y
puts "-----"
result = teleso.binary_double_and_add(3,3,7)
puts "inverze = #{teleso.EEA(15,19)}"
teleso.print_poly_from_number(15)

#puts teleso.binary_div(7,3)
# puts "deg: #{teleso.degree(result)}"
# puts "div: #{teleso.binary_div(9,2)}"
# sinv = 9
# inv = teleso.EEA(sinv,15)
# puts teleso.binary_double_and_add(inv,sinv,15)


