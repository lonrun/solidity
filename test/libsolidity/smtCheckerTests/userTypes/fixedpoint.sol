// Represent a 18 decimal, 256 bit wide fixed point type using a user defined value type.
type UFixed256x18 is uint256;

/// A minimal library to do fixed point operations on UFixed256x18.
library FixedMath {
	uint constant multiplier = 10**18;
	/// Adds two UFixed256x18 numbers. Reverts on overflow, relying on checked arithmetic on
	/// uint256.
	function add(UFixed256x18 a, UFixed256x18 b) internal pure returns (UFixed256x18) {
		return UFixed256x18.wrap(UFixed256x18.unwrap(a) + UFixed256x18.unwrap(b));
	}
	/// Multiplies UFixed256x18 and uint256. Reverts on overflow, relying on checked arithmetic on
	/// uint256.
	function mul(UFixed256x18 a, uint256 b) internal pure returns (UFixed256x18) {
		return UFixed256x18.wrap(UFixed256x18.unwrap(a) * b);
	}
	/// Take the floor of a UFixed256x18 number.
	/// @return the largest integer that does not exceed `a`.
	function floor(UFixed256x18 a) internal pure returns (uint256) {
		return UFixed256x18.unwrap(a) / multiplier;
	}
	/// Turns a uint256 into a UFixed256x18 of the same value.
	/// Reverts if the integer is too large.
	function toUFixed256x18(uint256 a) internal pure returns (UFixed256x18) {
		return UFixed256x18.wrap(a * multiplier);
	}
}

contract TestFixedMath {
	function add(UFixed256x18 a, UFixed256x18 b) internal pure returns (UFixed256x18) {
		return FixedMath.add(a, b);
	}
	function mul(UFixed256x18 a, uint256 b) internal pure returns (UFixed256x18) {
		return FixedMath.mul(a, b);
	}
	function floor(UFixed256x18 a) internal pure returns (uint256) {
		return FixedMath.floor(a);
	}
	function toUFixed256x18(uint256 a) internal pure returns (UFixed256x18) {
		return FixedMath.toUFixed256x18(a);
	}

	function f() public pure {
		assert(UFixed256x18.unwrap(add(UFixed256x18.wrap(0), UFixed256x18.wrap(0))) == 0);
		assert(UFixed256x18.unwrap(add(UFixed256x18.wrap(25), UFixed256x18.wrap(45))) == 0x46);
		assert(UFixed256x18.unwrap(add(UFixed256x18.wrap(25), UFixed256x18.wrap(45))) == 46); // should fail
	}

	function g() public pure {
		assert(UFixed256x18.unwrap(mul(UFixed256x18.wrap(340282366920938463463374607431768211456), 20)) == 6805647338418769269267492148635364229120);
		assert(UFixed256x18.unwrap(mul(UFixed256x18.wrap(340282366920938463463374607431768211456), 20)) == 0); // should fail
	}

	function h() public pure {
		assert(floor(UFixed256x18.wrap(11579208923731619542357098500868790785326998665640564039457584007913129639930)) == 11579208923731619542357098500868790785326998665640564039457);
		assert(floor(UFixed256x18.wrap(115792089237316195423570985008687907853269984665640564039457584007913129639935)) == 115792089237316195423570985008687907853269984665640564039457);
		assert(floor(UFixed256x18.wrap(11579208923731619542357098500868790785326998665640564039457584007913129639930)) == 0); // should fail
	}

	function i() public pure {
		assert(UFixed256x18.unwrap(toUFixed256x18(0)) == 0);
		assert(UFixed256x18.unwrap(toUFixed256x18(5)) == 5000000000000000000);
		assert(UFixed256x18.unwrap(toUFixed256x18(115792089237316195423570985008687907853269984665640564039457)) == 115792089237316195423570985008687907853269984665640564039457000000000000000000);
		assert(UFixed256x18.unwrap(toUFixed256x18(5)) == 5); // should fail
	}

}
// ====
// SMTEngine: all
// SMTIgnoreCex: yes
// ----
// Warning 6328: (1886-1970): CHC: Assertion violation happens here.
// Warning 6328: (2165-2266): CHC: Assertion violation happens here.
// Warning 6328: (2675-2791): CHC: Assertion violation happens here.
// Warning 6328: (3161-3212): CHC: Assertion violation happens here.
// Info 1180: Contract invariant(s) for :FixedMath:\n(true || true)\nReentrancy property(ies) for :FixedMath:\n((<errorCode> = 0) && ((:var 1) = (:var 3)) && (multiplier' = multiplier))\n<errorCode> = 0 -> no errors\n<errorCode> = 1 -> Overflow at UFixed256x18.unwrap(a) + UFixed256x18.unwrap(b)\n<errorCode> = 2 -> Overflow at UFixed256x18.unwrap(a) * b\n<errorCode> = 3 -> Division by zero at UFixed256x18.unwrap(a) / multiplier\n<errorCode> = 5 -> Overflow at a * multiplier\n<errorCode> = 6 -> Overflow at UFixed256x18.unwrap(a) + UFixed256x18.unwrap(b)\n<errorCode> = 7 -> Overflow at UFixed256x18.unwrap(a) * b\n<errorCode> = 8 -> Division by zero at UFixed256x18.unwrap(a) / multiplier\n<errorCode> = 10 -> Overflow at a * multiplier\n<errorCode> = 11 -> Assertion failed at assert(UFixed256x18.unwrap(add(UFixed256x18.wrap(0), UFixed256x18.wrap(0))) == 0)\n<errorCode> = 12 -> Assertion failed at assert(UFixed256x18.unwrap(add(UFixed256x18.wrap(25), UFixed256x18.wrap(45))) == 0x46)\n<errorCode> = 13 -> Assertion failed at assert(UFixed256x18.unwrap(add(UFixed256x18.wrap(25), UFixed256x18.wrap(45))) == 46)\n<errorCode> = 15 -> Assertion failed at assert(UFixed256x18.unwrap(mul(UFixed256x18.wrap(340282366920938463463374607431768211456), 20)) == 6805647338418769269267492148635364229120)\n<errorCode> = 16 -> Assertion failed at assert(UFixed256x18.unwrap(mul(UFixed256x18.wrap(340282366920938463463374607431768211456), 20)) == 0)\n<errorCode> = 18 -> Assertion failed at assert(floor(UFixed256x18.wrap(11579208923731619542357098500868790785326998665640564039457584007913129639930)) == 11579208923731619542357098500868790785326998665640564039457)\n<errorCode> = 19 -> Assertion failed at assert(floor(UFixed256x18.wrap(115792089237316195423570985008687907853269984665640564039457584007913129639935)) == 115792089237316195423570985008687907853269984665640564039457)\n<errorCode> = 20 -> Assertion failed at assert(floor(UFixed256x18.wrap(11579208923731619542357098500868790785326998665640564039457584007913129639930)) == 0)\n<errorCode> = 22 -> Assertion failed at assert(UFixed256x18.unwrap(toUFixed256x18(0)) == 0)\n<errorCode> = 23 -> Assertion failed at assert(UFixed256x18.unwrap(toUFixed256x18(5)) == 5000000000000000000)\n<errorCode> = 24 -> Assertion failed at assert(UFixed256x18.unwrap(toUFixed256x18(115792089237316195423570985008687907853269984665640564039457)) == 115792089237316195423570985008687907853269984665640564039457000000000000000000)\n<errorCode> = 25 -> Assertion failed at assert(UFixed256x18.unwrap(toUFixed256x18(5)) == 5)\n
