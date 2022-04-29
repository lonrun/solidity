contract C {
	mapping (uint => uint[][]) public m;

	constructor() {
		m[0].push();
		m[0].push();
		m[0][1].push();
		m[0][1].push();
		m[0][1].push();
		m[0][1][2] = 42;
	}

	function f() public view {
		uint y = this.m(0,1,2);
		assert(y == m[0][1][2]); // should hold
		assert(y == 1); // should fail
	}
}
// ====
// SMTEngine: all
// SMTIgnoreCex: yes
// ----
// Warning 6328: (274-288): CHC: Assertion violation happens here.
// Info 1180: Contract invariant(s) for :C:\n(true || true || !(m[0].length <= 1))\n(true || true || !(m[0][1].length <= 2))\n(true || true || true || true || true)\nReentrancy property(ies) for :C:\n(((<errorCode> = 0) && ((:var 1) = (:var 3)) && (m' = m)) || true || true || true || true || true || true)\n<errorCode> = 0 -> no errors\n<errorCode> = 1 -> Out of bounds access at m[0][1]\n<errorCode> = 2 -> Out of bounds access at m[0][1][2]\n<errorCode> = 3 -> Assertion failed at assert(y == m[0][1][2])\n<errorCode> = 4 -> Assertion failed at assert(y == 1)\n<errorCode> = 6 -> Out of bounds access at m[0][1]\n<errorCode> = 7 -> Out of bounds access at m[0][1]\n<errorCode> = 8 -> Out of bounds access at m[0][1]\n<errorCode> = 9 -> Out of bounds access at m[0][1]\n<errorCode> = 10 -> Out of bounds access at m[0][1][2]\n
