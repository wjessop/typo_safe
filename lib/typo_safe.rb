require "typo_safe/version"
require 'text'

module TypoSafe
	@@maximum_levenshtein_distance_for_match = 4

	def method_missing(requested_method, *args, &block)
		distances = []
		methods.select{ |m|
			a = method(m).arity
			(a >= 0 && a == args.size) || (a < 0 && (0 - a - 1) <= args.size)
		}.each { |meth|
			distance = Text::Levenshtein.distance(requested_method.to_s, meth.to_s)
			distances << {meth: meth, dist: Text::Levenshtein.distance(requested_method.to_s, meth.to_s)} if distance <= @@maximum_levenshtein_distance_for_match
		}

		if distances.size == 0
			super
		else
			closest_match = distances.sort_by{|dist| dist[:dist]}.first
			if block_given?
				send(closest_match[:meth], *args, &block)
			else
				send(closest_match[:meth], *args)
			end
		end
	end

	def self.maximum_levenshtein_distance_for_match=(val)
		@@maximum_levenshtein_distance_for_match = val
	end
end
