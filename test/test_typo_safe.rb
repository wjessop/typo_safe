require 'minitest/autorun'
$:.unshift File.join(File.dirname(__FILE__), '..')
require 'typo_safe'

class TestTypoSafe < MiniTest::Unit::TestCase
	def setup
		@foo = Class.new do
			include TypoSafe
			def tset; true; end
			def xxxxxxxxxx; true; end
			def aaaaaaaaaa(an_obj, str); yield(an_obj, str); end
			def bbbbbbbbbb(an_obj, str); an_obj.ping(str); end
			def cccccccccc; end
			def ccccccccbb(an_arg); end

			# Methods for test_ignores_methods_that_are_not_arg_or_block_campatible
			def arity_test_aaaaaaa(arg, other_arg); "aaaaaaa"; end
			def arity_test_aaaaaab(arg); "aaaaaab"; end
      private
      def secret; "secret"; end
		end.new
	end

	def test_typo_method_dispatch
		assert @foo.test
	end

	def test_passes_args_and_no_block
		tbc = MiniTest::Mock.new
		tbc.expect :ping, true, ["foo"]
		@foo.bbbbbbbbba(tbc, "foo")
		assert tbc.verify
	end

	def test_passes_args_and_block
		tbc = MiniTest::Mock.new
		tbc.expect :ping, true, ["foo"]
		@foo.aaaaaaaaab(tbc, "foo") {|obj, arg| obj.ping(arg)}
		assert tbc.verify
	end

	def test_requires_minimum_similarity
		error = assert_raises(NoMethodError) {@foo.kdygfnkudfjh}
		assert error.message.match /undefined method `kdygfnkudfjh' for #<#<Class/
	end

	def test_setting_minimum_similarity
		TypoSafe::maximum_levenshtein_distance_for_match = 2
		assert_raises(NoMethodError) {@foo.xxxxxxxyyy}
	end

	def test_ignores_methods_that_are_not_arg_or_block_campatible
		assert_equal @foo.arity_test_aaaaaax(1, 2), "aaaaaaa"
		assert_equal @foo.arity_test_aaaaaax(1), "aaaaaab"
	end

  def test_ignores_private_methods
    assert_raises(NoMethodError) { @foo.secret }
    assert_raises(NoMethodError) { @foo.sekrit }
  end
end
