module number_theory.prime;
import std.typecons;

/// Run sieve of Eular on [1, max]
auto sieveOfEuler(T)(T max) {
	bool[] not_prime = new bool[max+1];
	T[] result = [];
	not_prime[1] = true;
	foreach(i; 2..max+1) {
		if (!not_prime[i]) {
			result ~= [i];
		}
		foreach(j; result) {
			if (j > max / i) {
				break;
			}
			not_prime[j * i] = true;
			if (i % j == 0) {
				break;
			}
		}
	}
	return tuple(not_prime, result);
}

/// Return all prime numbers in [1, max]
auto generatePrimeNumbers(T)(T max) {
	auto ret = sieveOfEuler!T(max);
	return ret[1];
}

unittest {
	import std.algorithm.comparison : equal;
	assert(equal(generatePrimeNumbers(10), [2,3,5,7]));
	assert(equal(generatePrimeNumbers(97), [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]));
	assert(equal(generatePrimeNumbers(100), [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]));
}
