require_relative "gf"
require "test/unit"
require 'ruby-prof'

class TestGf < Test::Unit::TestCase
  def setup
    #RubyProf.start
    
    @teleso = GF.new(2,8)
  end
  def test_factor
    assert_equal(@teleso.factor(100), [[2, 2], [5, 2]])
    assert_equal(@teleso.factor(2), [[2, 1]])
    assert_equal(@teleso.factor(7), [[7, 1]])
    assert_equal(@teleso.factor(1729382256), [[2, 4], [3, 2], [7, 1], [17, 1], [43, 1], [2347, 1]])
  end
  
  def test_parse_string_to_number
    h0 = "1"
    h1 = "x + 1"
    h2 = "x"
    h3 = "x^2 + x + 1"
    h5 = "x^57 + x^56 + x^55 + x^51 + x^49 + x^47 + x^46 + x^42 + x^39 + x^31 + x^28 + x^27 + x^26 + x^25 + x^23 + x^22 + x^19 + x^13 + x^12 + x^10 + x^8 + x^7 + x^5 + x^4 + x^3"
    h6 = "x^60 + x^59 + 1"
    assert_equal(@teleso.parse_string_to_number(h0), 1)
    assert_equal(@teleso.parse_string_to_number(h1), 3)
    assert_equal(@teleso.parse_string_to_number(h2), 2)
    assert_equal(@teleso.parse_string_to_number(h3), 7) 
    assert_equal(@teleso.parse_string_to_number(h5), 255232385598633400)
    assert_equal(@teleso.parse_string_to_number(h6), 1729382256910270465)  
  end
  
  def test_print_poly_from_number
    h0 = 1
    h1 = 3
    h2 = 2
    h3 = 7
    h5 = 255232385598633400
    h6 = 1729382256910270465
    assert_equal(@teleso.print_poly_from_number(h0), "1")
    assert_equal(@teleso.print_poly_from_number(h1), "x + 1")
    assert_equal(@teleso.print_poly_from_number(h2), "x")
    assert_equal(@teleso.print_poly_from_number(h3), "x^2 + x + 1")
    assert_equal(@teleso.print_poly_from_number(h5), h5 = "x^57 + x^56 + x^55 + x^51 + x^49 + x^47 + x^46 + x^42 + x^39 + x^31 + x^28 + x^27 + x^26 + x^25 + x^23 + x^22 + x^19 + x^13 + x^12 + x^10 + x^8 + x^7 + x^5 + x^4 + x^3")
    assert_equal(@teleso.print_poly_from_number(h6), "x^60 + x^59 + 1")
  end
  
  def test_CRT
    l = [1,47,14]
    m = [[2,2],[3,4],[5,2]]
    assert_equal(@teleso.CRT(l,m), 6689)
    l = [2,3,2]
    m = [[3,1],[5,1],[7,1]]
    assert_equal(@teleso.CRT(l,m), 23)
    l = [2,1,7]
    m = [[3,1],[8,1],[13,1]]
    assert_equal(@teleso.CRT(l,m), 137)
  end
  
  def test_degree
    h0 = "1"
    h1 = "x + 1"
    h2 = "x"
    h3 = "x^2 + x + 1"
    h5 = "x^57 + x^56 + x^55 + x^51 + x^49 + x^47 + x^46 + x^42 + x^39 + x^31 + x^28 + x^27 + x^26 + x^25 + x^23 + x^22 + x^19 + x^13 + x^12 + x^10 + x^8 + x^7 + x^5 + x^4 + x^3"
    h6 = "x^60 + x^59 + 1"
    assert_equal(@teleso.degree(@teleso.parse_string_to_number(h0)),0)
    assert_equal(@teleso.degree(@teleso.parse_string_to_number(h1)),1)
    assert_equal(@teleso.degree(@teleso.parse_string_to_number(h2)),1)
    assert_equal(@teleso.degree(@teleso.parse_string_to_number(h3)),2)
    assert_equal(@teleso.degree(@teleso.parse_string_to_number(h5)),57)
    assert_equal(@teleso.degree(@teleso.parse_string_to_number(h6)),60)
  end
  
  def test_EEA_numbers 
    assert_equal(@teleso.EEA_numbers(3,13),9)
    assert_equal(@teleso.EEA_numbers(7,101),29)
    assert_equal(@teleso.EEA_numbers(20,1321321),1255255)
  end
  
  def test_EEA
    h0 = "x^2"
    h0_inv = "x^58 + x^57"
    h1 = "x^2 + x + 1"
    h1_inv = "x^59 + x^57 + x^56 + x^54 + x^53 + x^51 + x^50 + x^48 + x^47 + x^45 + x^44 + x^42 + x^41 + x^39 + x^38 + x^36 + x^35 + x^33 + x^32 + x^30 + x^29 + x^27 + x^26 + x^24 + x^23 + x^21 + x^20 + x^18 + x^17 + x^15 + x^14 + x^12 + x^11 + x^9 + x^8 + x^6 + x^5 + x^3 + x^2 + 1"
    h2 = "x^57 + x^56 + x^55 + x^51 + x^49 + x^47 + x^46 + x^42 + x^39 + x^31 + x^28 + x^27 + x^26 + x^25 + x^23 + x^22 + x^19 + x^13 + x^12 + x^10 + x^8 + x^7 + x^5 + x^4 + x^3"
    h2_inv = "x^57 + x^56 + x^55 + x^54 + x^53 + x^48 + x^45 + x^43 + x^41 + x^40 + x^39 + x^38 + x^36 + x^35 + x^33 + x^32 + x^31 + x^30 + x^24 + x^23 + x^19 + x^18 + x^17 + x^16 + x^14 + x^13 + x^11 + x^10 + x^7 + x^3 + x^2"
    irr_poly =  @teleso.parse_string_to_number "x^60 + x^59 + 1"
    assert_equal(@teleso.EEA(@teleso.parse_string_to_number(h0),irr_poly),@teleso.parse_string_to_number(h0_inv))
    assert_equal(@teleso.EEA(@teleso.parse_string_to_number(h1),irr_poly),@teleso.parse_string_to_number(h1_inv))
    assert_equal(@teleso.EEA(@teleso.parse_string_to_number(h2),irr_poly),@teleso.parse_string_to_number(h2_inv))
  end
  
  def test_binary_double_and_add
    irr_poly =  @teleso.parse_string_to_number "x^60 + x^59 + 1"
    h2 = "x^57 + x^56 + x^55 + x^51 + x^49 + x^47 + x^46 + x^42 + x^39 + x^31 + x^28 + x^27 + x^26 + x^25 + x^23 + x^22 + x^19 + x^13 + x^12 + x^10 + x^8 + x^7 + x^5 + x^4 + x^3"
    h2_inv = "x^57 + x^56 + x^55 + x^54 + x^53 + x^48 + x^45 + x^43 + x^41 + x^40 + x^39 + x^38 + x^36 + x^35 + x^33 + x^32 + x^31 + x^30 + x^24 + x^23 + x^19 + x^18 + x^17 + x^16 + x^14 + x^13 + x^11 + x^10 + x^7 + x^3 + x^2"
    h3 = "x^25+x^3+1"
    h3_res = "x^59 + x^58 + x^57 + x^55 + x^54 + x^53 + x^48 + x^46 + x^45 + x^44 + x^39 + x^38 + x^37 + x^35 + x^34 + x^33 + x^32 + x^28 + x^27 + x^23 + x^22 + x^20 + x^18 + x^17 + x^16 + x^15 + x^14 + x^13 + x^12 + x^10 + x^9 + x^8 + x^6 + x^5 + x^2 + x"
    assert_equal(@teleso.binary_double_and_add(4,4,irr_poly),16)
    assert_equal(@teleso.binary_double_and_add(@teleso.parse_string_to_number(h2),@teleso.parse_string_to_number(h2_inv),irr_poly),1)
    assert_equal(@teleso.binary_double_and_add(@teleso.parse_string_to_number(h2),@teleso.parse_string_to_number(h3),irr_poly),@teleso.parse_string_to_number(h3_res))
    
    irr_poly =  @teleso.parse_string_to_number "x^3 + x + 1"
    assert_equal(@teleso.binary_double_and_add(5,2,irr_poly),1)
    assert_equal(@teleso.binary_double_and_add(7,7,irr_poly),3)
    assert_equal(@teleso.binary_double_and_add(6,7,irr_poly),4)
    assert_equal(@teleso.binary_double_and_add(1,1,irr_poly),1)
    assert_equal(@teleso.binary_double_and_add(5,7,irr_poly),6)
    
    irr_poly =  @teleso.parse_string_to_number "x^4 + x + 1"
    assert_equal(@teleso.binary_double_and_add(15,15,irr_poly),10)
    assert_equal(@teleso.binary_double_and_add(15,14,irr_poly),5)
    assert_equal(@teleso.binary_double_and_add(9,7,irr_poly),10)
  end
  
  def test_square
    irr_poly =  @teleso.parse_string_to_number "x^4 + x + 1"
    assert_equal(@teleso.square(14,10000000000,irr_poly),6)
    assert_equal(@teleso.square(2,999999999,irr_poly),10)
    assert_equal(@teleso.square(2,991,irr_poly),2)
    
    irr_poly =  @teleso.parse_string_to_number "x^60 + x^59 + 1"
    h3 = "x^25+x^3+1"
    h3_991 = "x^59 + x^57 + x^56 + x^54 + x^53 + x^51 + x^50 + x^49 + x^47 + x^45 + x^44 + x^43 + x^42 + x^41 + x^40 + x^37 + x^36 + x^33 + x^32 + x^28 + x^27 + x^25 + x^24 + x^23 + x^22 + x^20 + x^19 + x^16 + x^15 + x^11 + x^8 + x^7 + x^5 + x^2 + x"
    h3_19031992 = "x^59 + x^58 + x^56 + x^55 + x^54 + x^53 + x^51 + x^50 + x^48 + x^47 + x^46 + x^45 + x^44 + x^43 + x^42 + x^41 + x^40 + x^39 + x^35 + x^34 + x^33 + x^32 + x^29 + x^28 + x^27 + x^25 + x^24 + x^23 + x^22 + x^21 + x^20 + x^18 + x^17 + x^16 + x^15 + x^9 + x^8 + x^7 + x^6 + x^5 + x^2 + 1"
    assert_equal(@teleso.square(@teleso.parse_string_to_number(h3),991,irr_poly),@teleso.parse_string_to_number(h3_991))
    assert_equal(@teleso.square(@teleso.parse_string_to_number(h3),190319921903199219031992,irr_poly),@teleso.parse_string_to_number(h3_19031992))
  end
  
  def test1_discrete_log
    g_string = "x"
    h_string = "x^57+x^56 +x^55 +x^51 +x^49 +x^47 +x^46 +x^42 +x^39 +x^31 +x^28 +x^27 +x^26 +x^25 + x^23 +x^22 +x^19 +x^13 +x^12 +x^10 +x^8 +x^7 +x^5 +x^4 +x^3"
    irr_string = "x^60 + x^59 + 1"
    
    irr_poly =  @teleso.parse_string_to_number irr_string
    h_poly = @teleso.parse_string_to_number h_string
    g_poly = @teleso.parse_string_to_number g_string
    
    test1 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
    assert_equal(test1,1007177060085253286)
  end
  
  def test2_discrete_log
    g_string = "x"
    h_string = "x^57 +x^56 +x^55 +x^54 +x^51 +x^46 +x^45 +x^44 +x^43 +x^41 +x^40 +x^39 +x^32 +x^26 + x^24 +x^22 +x^21 +x^19 +x^18 +x^16 +x^15 +x^11 +x^7 +x^6 +x^5 +x^4 +x^2"
    irr_string = "x^60 + x^59 + 1"
    
    irr_poly =  @teleso.parse_string_to_number irr_string
    h_poly = @teleso.parse_string_to_number h_string
    g_poly = @teleso.parse_string_to_number g_string
    
    test2 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
    assert_equal(test2,852503841371245549)
  end
  
  def test3_discrete_log
    g_string = "x"
    h_string = "x^59+x^58+x^57+x^56+x^54+x^52+x^51+x^50+x^49+x^45+x^40+x^38+x^35+x^34+x^32+x^31+ x^26 +x^24 +x^23 +x^22 +x^21 +x^20 +x^19 +x^17 +x^16 +x^15 +x^12 +x^10 +x^9 +x^7 +x^5 +x^3 +x^2"
    irr_string = "x^60 + x^59 + 1"
    
    irr_poly =  @teleso.parse_string_to_number irr_string
    h_poly = @teleso.parse_string_to_number h_string
    g_poly = @teleso.parse_string_to_number g_string
    
    test3 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
    assert_equal(test3,901655856582054837)
  end
  
  def test4_discrete_log
    g_string = "x"
    h_string = "x^59 +x^58 +x^56 +x^50 +x^49 +x^48 +x^46 +x^40 +x^34 +x^32 +x^30 +x^29 +x^27 +x^26 + x^25 +x^23 +x^22 +x^21 +x^20 +x^18 +x^17 +x^15 +x^13 +x^11 +x^9 +x^8 +x^5 +x^4"
    irr_string = "x^60 + x^59 + 1"
    
    irr_poly =  @teleso.parse_string_to_number irr_string
    h_poly = @teleso.parse_string_to_number h_string
    g_poly = @teleso.parse_string_to_number g_string
    
    test4 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
    assert_equal(test4,999103903541746660)
  end
  
  def test5_discrete_log
    g_string = "x"
    h_string = "x^55 +x^54 +x^52 +x^50 +x^49 +x^46 +x^45 +x^44 +x^43 +x^42 +x^39 +x^38 +x^37 +x^36 +x^34 + x^32 +x^31 +x^30 +x^28 +x^26 +x^23 +x^22 +x^18 +x^16 +x^13 +x^12 +x^9 +x^8 +x^6 +x^2 +1"
    irr_string = "x^60 + x^59 + 1"
    
    irr_poly =  @teleso.parse_string_to_number irr_string
    h_poly = @teleso.parse_string_to_number h_string
    g_poly = @teleso.parse_string_to_number g_string
    
    test5 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
    assert_equal(test5,959514753231807386)
  end
  
  def test6_discrete_log
    g_string = "x"
    h_string = "x^58 +x^55 +x^52 +x^51 +x^50 +x^49 +x^46 +x^45 +x^44 +x^43 +x^42 +x^41 +x^39 +x^37 + x^35 +x^33 +x^30 +x^28 +x^27 +x^26 +x^25 +x^23 +x^22 +x^21 +x^14 +x^10 +x^2"
    irr_string = "x^60 + x^59 + 1"
    
    irr_poly =  @teleso.parse_string_to_number irr_string
    h_poly = @teleso.parse_string_to_number h_string
    g_poly = @teleso.parse_string_to_number g_string
    
    test6 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
    assert_equal(test6,842130573188218643)
  end
  def test7_discrete_log
    g_string = "x"
    h_string = "x^58 +x^57 +x^55 +x^52 +x^50 +x^48 +x^47 +x^45 +x^44 +x^42 +x^41 +x^40 +x^37 +x^36 + x^35 +x^32 +x^29 +x^27 +x^19 +x^17 +x^12 +x^10 +x^4 +x^3 +x^2 +x"
    irr_string = "x^60 + x^59 + 1"
    
    irr_poly =  @teleso.parse_string_to_number irr_string
    h_poly = @teleso.parse_string_to_number h_string
    g_poly = @teleso.parse_string_to_number g_string
    
    test7 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
    assert_equal(test7,765379143265315734)
  end
  def test8_discrete_log
    g_string = "x"
    h_string = "x^59+x^58+x^56+x^55+x^52+x^51+x^50+x^46+x^43+x^42+x^40+x^37+x^35+x^34+x^33+x^26+ x^25 +x^23 +x^22 +x^21 +x^18 +x^16 +x^15 +x^13 +x^12 +x^11 +x^9 +x^8 +x^6 +x^5 +x^4 +x^2 +x"
    irr_string = "x^60 + x^59 + 1"
    
    irr_poly =  @teleso.parse_string_to_number irr_string
    h_poly = @teleso.parse_string_to_number h_string
    g_poly = @teleso.parse_string_to_number g_string
    
    test8 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
    assert_equal(test8,1116813476543245197)
  end
  def test9_discrete_log
    g_string = "x"
    h_string = "x^58 +x^55 +x^54 +x^52 +x^51 +x^50 +x^49 +x^48 +x^44 +x^43 +x^41 +x^40 +x^37 +x^34 +x^33 + x^32 +x^29 +x^27 +x^26 +x^21 +x^19 +x^17 +x^15 +x^13 +x^10 +x^9 +x^6 +x^5 +x^4 +x^2 +1"
    irr_string = "x^60 + x^59 + 1"
    
    irr_poly =  @teleso.parse_string_to_number irr_string
    h_poly = @teleso.parse_string_to_number h_string
    g_poly = @teleso.parse_string_to_number g_string
    
    test9 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
    assert_equal(test9,877051632908727171)
  end
  def test10_discrete_log
    g_string = "x"
    h_string = "x^59 +x^56 +x^52 +x^47 +x^46 +x^44 +x^38 +x^37 +x^34 +x^31 +x^30 +x^27 +x^25 +x^24 + x^20 +x^19 +x^18 +x^16 +x^15 +x^14 +x^12 +x^7 +x^4 +x^2"
    irr_string = "x^60 + x^59 + 1"
    
    irr_poly =  @teleso.parse_string_to_number irr_string
    h_poly = @teleso.parse_string_to_number h_string
    g_poly = @teleso.parse_string_to_number g_string
    
    test10 = @teleso.discrete_log(h_poly,g_poly,(@teleso.order irr_poly) -1, irr_poly)
    assert_equal(test10,1113556865784821720)
    # result = RubyProf.stop
    # #Print a flat profile to text
    # printer = RubyProf::FlatPrinter.new(result)
    # printer.print(STDOUT)
  end
end