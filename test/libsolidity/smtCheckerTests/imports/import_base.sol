==== Source: base ====
contract Base {
	uint x;
	address a;
	function f() internal returns (uint) {
		a = address(this);
		++x;
		return 2;
	}
}
==== Source: der ====
import "base";
contract Der is Base {
	function g(uint y) public {
		require(x < 10); // added to restrict the search space and avoid non-determinsm in Spacer
		x += f();
		assert(y > x);
	}
}
// ====
// SMTEngine: all
// ----
// Warning 6328: (der:173-186): CHC: Assertion violation happens here.\nCounterexample:\nx = 3, a = 0x0\ny = 0\n\nTransaction trace:\nDer.constructor()\nState: x = 0, a = 0x0\nDer.g(0)\n    Base.f() -- internal call
// Info 1180: Contract invariant(s) for base:Base:\n(true || true)\nReentrancy property(ies) for base:Base:\n((<errorCode> = 0) && ((:var 2) = (:var 5)) && (x' = x) && (a' = a))\n<errorCode> = 0 -> no errors\n<errorCode> = 1 -> Overflow at ++x\n<errorCode> = 2 -> Overflow at ++x\n<errorCode> = 3 -> Overflow at x += f()\n<errorCode> = 4 -> Assertion failed at assert(y > x)\n
