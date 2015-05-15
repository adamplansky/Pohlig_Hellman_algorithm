require_relative "gf"
require 'ruby-prof'

PROF = false
if PROF == true
 RubyProf.start
end


$test_counter = 1
def print_log_output g,h,result
  puts "---- test#{$test_counter} ----"
  puts "g(x) = #{g}, h(x) = #{h}"
  puts "log[g(x),h(x)] = #{result}"
  puts "--------------\n\n"
  $test_counter+=1
end

@teleso = GF.new(2,8)

#def test1_discrete_log
g_string = "x"
h_string = "x^57+x^56 +x^55 +x^51 +x^49 +x^47 +x^46 +x^42 +x^39 +x^31 +x^28 +x^27 +x^26 +x^25 + x^23 +x^22 +x^19 +x^13 +x^12 +x^10 +x^8 +x^7 +x^5 +x^4 +x^3"
irr_string = "x^60 + x^59 + 1"
    
irr_poly =  @teleso.parse_string_to_number irr_string
h_poly = @teleso.parse_string_to_number h_string
g_poly = @teleso.parse_string_to_number g_string
    
test1 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
#print_log_output(g_string,h_string, test1)
#assert_equal(test1,1007177060085253286)
#end
  
#def test2_discrete_log
g_string = "x"
h_string = "x^57 +x^56 +x^55 +x^54 +x^51 +x^46 +x^45 +x^44 +x^43 +x^41 +x^40 +x^39 +x^32 +x^26 + x^24 +x^22 +x^21 +x^19 +x^18 +x^16 +x^15 +x^11 +x^7 +x^6 +x^5 +x^4 +x^2"
irr_string = "x^60 + x^59 + 1"
    
irr_poly =  @teleso.parse_string_to_number irr_string
h_poly = @teleso.parse_string_to_number h_string
g_poly = @teleso.parse_string_to_number g_string
    
test2 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
#print_log_output(g_string,h_string, test2)
#assert_equal(test2,852503841371245549)
#end
  
#def test3_discrete_log
g_string = "x"
h_string = "x^59+x^58+x^57+x^56+x^54+x^52+x^51+x^50+x^49+x^45+x^40+x^38+x^35+x^34+x^32+x^31+ x^26 +x^24 +x^23 +x^22 +x^21 +x^20 +x^19 +x^17 +x^16 +x^15 +x^12 +x^10 +x^9 +x^7 +x^5 +x^3 +x^2"
irr_string = "x^60 + x^59 + 1"
    
irr_poly =  @teleso.parse_string_to_number irr_string
h_poly = @teleso.parse_string_to_number h_string
g_poly = @teleso.parse_string_to_number g_string
    
test3 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
#print_log_output(g_string,h_string, test3)
#assert_equal(test3,901655856582054837)
#end
  
#def test4_discrete_log
g_string = "x"
h_string = "x^59 +x^58 +x^56 +x^50 +x^49 +x^48 +x^46 +x^40 +x^34 +x^32 +x^30 +x^29 +x^27 +x^26 + x^25 +x^23 +x^22 +x^21 +x^20 +x^18 +x^17 +x^15 +x^13 +x^11 +x^9 +x^8 +x^5 +x^4"
irr_string = "x^60 + x^59 + 1"
    
irr_poly =  @teleso.parse_string_to_number irr_string
h_poly = @teleso.parse_string_to_number h_string
g_poly = @teleso.parse_string_to_number g_string
    
test4 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
#print_log_output(g_string,h_string, test4)
#assert_equal(test4,999103903541746660)
#end
  
#def test5_discrete_log
g_string = "x"
h_string = "x^55 +x^54 +x^52 +x^50 +x^49 +x^46 +x^45 +x^44 +x^43 +x^42 +x^39 +x^38 +x^37 +x^36 +x^34 + x^32 +x^31 +x^30 +x^28 +x^26 +x^23 +x^22 +x^18 +x^16 +x^13 +x^12 +x^9 +x^8 +x^6 +x^2 +1"
irr_string = "x^60 + x^59 + 1"
    
irr_poly =  @teleso.parse_string_to_number irr_string
h_poly = @teleso.parse_string_to_number h_string
g_poly = @teleso.parse_string_to_number g_string
    
test5 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
#print_log_output(g_string,h_string, test5)
#assert_equal(test5,959514753231807386)
#end
  
# def test6_discrete_log
g_string = "x"
h_string = "x^58 +x^55 +x^52 +x^51 +x^50 +x^49 +x^46 +x^45 +x^44 +x^43 +x^42 +x^41 +x^39 +x^37 + x^35 +x^33 +x^30 +x^28 +x^27 +x^26 +x^25 +x^23 +x^22 +x^21 +x^14 +x^10 +x^2"
irr_string = "x^60 + x^59 + 1"
    
irr_poly =  @teleso.parse_string_to_number irr_string
h_poly = @teleso.parse_string_to_number h_string
g_poly = @teleso.parse_string_to_number g_string
    
test6 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
#print_log_output(g_string,h_string, test6)
#assert_equal(test6,842130573188218643)
#end
#def test7_discrete_log
g_string = "x"
h_string = "x^58 +x^57 +x^55 +x^52 +x^50 +x^48 +x^47 +x^45 +x^44 +x^42 +x^41 +x^40 +x^37 +x^36 + x^35 +x^32 +x^29 +x^27 +x^19 +x^17 +x^12 +x^10 +x^4 +x^3 +x^2 +x"
irr_string = "x^60 + x^59 + 1"
    
irr_poly =  @teleso.parse_string_to_number irr_string
h_poly = @teleso.parse_string_to_number h_string
g_poly = @teleso.parse_string_to_number g_string
    
test7 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
#print_log_output(g_string,h_string, test7)
#assert_equal(test7,765379143265315734)
#end
#def test8_discrete_log
g_string = "x"
h_string = "x^59+x^58+x^56+x^55+x^52+x^51+x^50+x^46+x^43+x^42+x^40+x^37+x^35+x^34+x^33+x^26+ x^25 +x^23 +x^22 +x^21 +x^18 +x^16 +x^15 +x^13 +x^12 +x^11 +x^9 +x^8 +x^6 +x^5 +x^4 +x^2 +x"
irr_string = "x^60 + x^59 + 1"
    
irr_poly =  @teleso.parse_string_to_number irr_string
h_poly = @teleso.parse_string_to_number h_string
g_poly = @teleso.parse_string_to_number g_string
    
test8 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
#print_log_output(g_string,h_string, test8)
#assert_equal(test8,1116813476543245197)
# end
#def test9_discrete_log
g_string = "x"
h_string = "x^58 +x^55 +x^54 +x^52 +x^51 +x^50 +x^49 +x^48 +x^44 +x^43 +x^41 +x^40 +x^37 +x^34 +x^33 + x^32 +x^29 +x^27 +x^26 +x^21 +x^19 +x^17 +x^15 +x^13 +x^10 +x^9 +x^6 +x^5 +x^4 +x^2 +1"
irr_string = "x^60 + x^59 + 1"
    
irr_poly =  @teleso.parse_string_to_number irr_string
h_poly = @teleso.parse_string_to_number h_string
g_poly = @teleso.parse_string_to_number g_string
    
test9 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
#print_log_output(g_string,h_string, test9)
#assert_equal(test9,877051632908727171)
#end
#def test10_discrete_log
g_string = "x"
h_string = "x^59 +x^56 +x^52 +x^47 +x^46 +x^44 +x^38 +x^37 +x^34 +x^31 +x^30 +x^27 +x^25 +x^24 + x^20 +x^19 +x^18 +x^16 +x^15 +x^14 +x^12 +x^7 +x^4 +x^2"
irr_string = "x^60 + x^59 + 1"
    
irr_poly =  @teleso.parse_string_to_number irr_string
h_poly = @teleso.parse_string_to_number h_string
g_poly = @teleso.parse_string_to_number g_string
    
test10 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
#print_log_output(g_string,h_string, test10)
#end
#assert_equal(test10,1113556865784821720)
if PROF == true
result = RubyProf.stop
#Print a flat profile to text
printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT)
end