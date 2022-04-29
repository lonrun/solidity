contract C
{
	function f(uint x, uint y) public pure {
		require(y > 0);
		uint z = x % y;
		assert(z < y);
	}
}
// ====
// SMTEngine: all
// ----
// Info 1180: Contract invariant(s) for :C:\n(true || true || true)\nReentrancy property(ies) for :C:\n(((<errorCode> = 0) && ((:var 0) = (:var 1))) || true || true || true || true)\n(true || true || ((<errorCode> = 0) && ((:var 0) = (:var 1))) || true || true)\n<errorCode> = 0 -> no errors\n<errorCode> = 1 -> Division by zero at x % y\n<errorCode> = 3 -> Assertion failed at assert(z < y)\n
