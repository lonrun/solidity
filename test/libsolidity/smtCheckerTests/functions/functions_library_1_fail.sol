library L
{
	function add(uint x, uint y) internal pure returns (uint) {
		require(x < 1000);
		require(y < 1000);
		return x + y;
	}
}

contract C
{
	function f(uint x) public pure {
		uint y = L.add(x, 999);
		assert(y < 1000);
	}
}
// ====
// SMTEngine: all
// ----
// Warning 6328: (212-228): CHC: Assertion violation happens here.\nCounterexample:\n\nx = 1\ny = 1000\n\nTransaction trace:\nC.constructor()\nC.f(1)\n    L.add(1, 999) -- internal call
// Info 1180: Contract invariant(s) for :L:\n(true || true)\nReentrancy property(ies) for :L:\n((<errorCode> = 0) && ((:var 0) = (:var 1)))\n<errorCode> = 0 -> no errors\n<errorCode> = 1 -> Overflow at x + y\n<errorCode> = 2 -> Overflow at x + y\n<errorCode> = 3 -> Assertion failed at assert(y < 1000)\n
