#!/usr/bin/ruby
#require 'ruby-prof'
class GF
  
  def initialize(p,m)
    @p = p
    @m = m
  end
  
  def print_gf
    puts "#{@p}^#{@m}"
  end
  
  
  def degree(v)
    return v.bit_length-1
#     if v != 0
#       result = -1
#       while v != 0
#         v >>= 1
#         result += 1
#       end
#       #puts result
#       return result
#     end
#     return 0
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
      #puts "i: #{i}, q: #{q}"
      q <<= 1
      #puts "po q <<= 1: q: #{q}"
      if r & (1 << (p2+i)) != 0
        q |= 1
        r ^= (rhs << i)
      end
    end
    return [q, r]
  end
  
  def get_bit number, bit
    return number[bit]
    #(number & 1 << bit) > 0 ? 1 : 0
  end


  def binary_double_and_add(_a,_b,_w,_d = degree(_w))
    results = 0
    degb = degree(_b)
    while degb > -1 do 
    #degb.downto(0) do |i|
    #i  = degb
      results <<= 1 
      if _b[degb] == 1 #( get_bit(_b, degb) == 1) 
        results ^= _a
      end
      if results[_d] == 1 #get_bit(results, _d) == 1) 
        results ^= _w
      end
      degb-=1
    end
    return results
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
  
  def EEA_numbers _a, _p
    r1 = _p
    r2 = _a
    g1 = 0
    g2 = 1
    while r2 > 1
      q0 = r1/r2
      q1 = r1%r2
      b = g1
      g1 = g2
      g2 = b-((g2*q0)%_p)
      r1 = r2
      r2 = q1
    end
    return (g2)%_p
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
    return newary.join(" + ")
  end
  
  def factor number
    ary = []
    for i in 2..Math.sqrt(number)
      cnt = 0
      while number % i == 0 do
        cnt+=1
        number = number/i
      end
      ary.push([i,cnt]) if cnt > 0
      break if number == 1
    end
    ary.push([number,1]) if number > 1
    return ary
  end
  
  def parse_string_to_number s
    number = 0
    ary = s.scan(/x\^\d+/)
    ary.each do |x|
      om = x.match(/\d+/)
      number += 1 << om[0].to_i
    end
    z_x = s.scan(/(x$|x[^^])/)[0]
    number += 2 if z_x != nil
    z = s.scan(/([+ ]\d)|^(\d)/)[0]
    number += 1 if z != nil
    return number
  end
  
  def order number
    2**degree(number)
  end
  
  def discrete_log a, g, ord, irr_poly
    start = Time.now
    facts = factor(ord)
    
    inverse_poly = EEA(g,irr_poly)
    print_poly_from_number(inverse_poly)
    l = [0] * facts.length
    facts.each_with_index do |f,i|
     # puts "f[0]: #{f[0]}, f[1]: #{f[1]}"
      no_a = a
      q = f[0]
      e = f[1]
      exphore = ord

      for j in 0..e-1
        expdole = q**(j+1)
        #puts "expdole: #{expdole}"
        exponent = exphore/expdole
        s1 = square(no_a, exponent,irr_poly)

        if j == 0
          s2 = square(g, exponent, irr_poly)
        end
        #puts s2
        res = 0
        #print_poly_from_number s1
        for k in 0..q-1
          #puts "hledam koef"
          if k == 0
            res = 1
          elsif k == 1
            res = s2
          else
            res = binary_double_and_add(res,s2,irr_poly)
          end
          if s1 == res
            #puts "nasel sem koeficient: #{k} pro #{f[0]} "
            l[i]+= (k*(q**j))
            no_a = binary_double_and_add(no_a, square(inverse_poly,k,irr_poly),irr_poly)
            #puts k
            break
          end
        end
        
      end
    end
    #puts l.inspect
    finish = Time.now

    diff = finish - start
    puts "celkovy cas v discrete_log byl: #{diff}"
    return CRT(l,facts)
  end
  
  def CRT r_array, f_array #, p #M == p-1
    mm = Array.new
    yy = Array.new
    modul = 1
    f_array.each do |n|
      modul *= n[0]**n[1]
    end
    r_array.each_with_index do |v,i|
      f = f_array[i]
      m = f[0]**f[1]
      mm[i] = modul / m
      yy[i] = EEA_numbers(mm[i],m)
    end
    x = 0
    for i in 0..yy.length-1
      x += ( r_array[i]*mm[i]*yy[i]  )
    end
    return x % modul
  end

  def square number, e, irr
    if e == 0
      return 1
    elsif e == 1
      return number
    end
    d = degree(e)
    d_irr = degree(irr) #speed optimilization
    zaklad = number
    i = d-1
    while i > -1
    #for i in (d-1).downto(0)
       #get_bit(e,i) == 1
      number = binary_double_and_add(number,number,irr,d_irr)
      number = binary_double_and_add(number,zaklad,irr,d_irr) if  e[i] != 0
      i-=1
    end
    return number
  end
end
