contract C {
	function f(bool b, uint a) pure public {
		require(a <= 256);
		if (b)
			revert();
		uint c = a + 1;
		if (b)
			c--;
		else
			c++;
		assert(c == a);
	}
}
// ====
// SMTEngine: all
// ----
// Warning 6328: (150-164): CHC: Assertion violation happens here.\nCounterexample:\n\nb = false\na = 0\nc = 2\n\nTransaction trace:\nC.constructor()\nC.f(false, 0)
// Info 1180: Contract invariant(s) for :C:\n(true || true || true)\nReentrancy property(ies) for :C:\n(true || true || true || true || ((<errorCode> = 0) && ((:var 0) = (:var 1))))\n<errorCode> = 0 -> no errors\n<errorCode> = 1 -> Overflow at a + 1\n<errorCode> = 2 -> Underflow at c--\n<errorCode> = 3 -> Overflow at c++\n<errorCode> = 4 -> Assertion failed at assert(c == a)\n
// Warning 6838: (122-123): BMC: Condition is always false.
