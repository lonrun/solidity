contract C {
	uint[] a;
	function f() public {
		a.push();
		assert(a[a.length - 1] == 0);
	}
}
// ====
// SMTEngine: all
// ----
// Info 1180: Reentrancy property(ies) for :C:\n(true || true || true || true || ((<errorCode> = 0) && ((:var 1) = (:var 3)) && (a' = a)) || true || true)\n(true || true || true || true || true || ((<errorCode> = 0) && ((:var 1) = (:var 3)) && (a' = a)) || true)\n<errorCode> = 0 -> no errors\n<errorCode> = 1 -> Underflow at a.length - 1\n<errorCode> = 2 -> Out of bounds access at a[a.length - 1]\n<errorCode> = 3 -> Assertion failed at assert(a[a.length - 1] == 0)\n
