package heat.core;

class Ease {
	// t: current time
	// b: starting value
	// c: change in value
	// d: duration
	public static function linear(t:Float, b:Float, c:Float, d:Float) {
		return b + c / d * t;
	}

	public static function quadIn(t:Float, b:Float, c:Float, d:Float) {
		t = t / d;
		return b + c * t * t;
	}

	public static function quadOut(t:Float, b:Float, c:Float, d:Float) {
		t = t / d;
		return b - c * t * (t - 2);
	}

	public static function quadInOut(t:Float, b:Float, c:Float, d:Float) {
		t = t / d * 2;
		if (t < 1) {
			return c / 2 * t * t + b;
		} else {
			return -c / 2 * ((t - 1) * (t - 3) - 1) + b;
		}
	}

	public static function quadOutIn(t:Float, b:Float, c:Float, d:Float) {
		if (t < d / 2) {
			return quadOut(t * 2, b, c / 2, d);
		} else {
			return quadIn((t * 2) - d, b + c / 2, c / 2, d);
		}
	}

	public static function cubicIn(t:Float, b:Float, c:Float, d:Float) {
		t = t / d;
		return c * t * t * t + b;
	}

	public static function cubicOut(t:Float, b:Float, c:Float, d:Float) {
		t = t / d - 1;
		return c * ((t * t * t) + 1) + b;
	}

	public static function cubicInOut(t:Float, b:Float, c:Float, d:Float) {
		t = t / d * 2;
		if (t < 1) {
			return c / 2 * t * t * t + b;
		} else {
			t = t - 2;
			return c / 2 * (t * t * t + 2) + b;
		}
	}

	public static function cubicOutIn(t:Float, b:Float, c:Float, d:Float) {
		if (t < d / 2) {
			return cubicOut(t * 2, b, c / 2, d);
		} else {
			return cubicIn((t * 2) - d, b + c / 2, c / 2, d);
		}
	}

	public static function quartIn(t:Float, b:Float, c:Float, d:Float) {
		t = t / d;
		return c * t * t * t * t + b;
	}

	public static function quartOut(t:Float, b:Float, c:Float, d:Float) {
		t = t / d - 1;
		return -c * ((t * t * t * t) - 1) + b;
	}

	public static function quartInOut(t:Float, b:Float, c:Float, d:Float) {
		t = t / d * 2;
		if (t < 1) {
			return c / 2 * (t * t * t * t) + b;
		} else {
			t = t - 2;
			return -c / 2 * ((t * t * t * t) - 2) + b;
		}
	}

	public static function quartOutIn(t:Float, b:Float, c:Float, d:Float) {
		if (t < d / 2) {
			return quartOut(t * 2, b, c / 2, d);
		} else {
			return quartIn((t * 2) - d, b + c / 2, c / 2, d);
		}
	}
	/**
			function quintIn(t, b, c, d)
		t = t / d
		return c * pow(t, 5) + b
		end
		  
		function quintOut(t, b, c, d)
		t = t / d - 1
		return c * (pow(t, 5) + 1) + b
		end
		  
		function quintInOut(t, b, c, d)
		t = t / d * 2
		if t < 1 then
			return c / 2 * pow(t, 5) + b
		else
			t = t - 2
			return c / 2 * (pow(t, 5) + 2) + b
		end
		end
		  
		function quintOutIn(t, b, c, d)
		if t < d / 2 then
			return quintOut(t * 2, b, c / 2, d)
		else
			return quintIn((t * 2) - d, b + c / 2, c / 2, d)
		end
		end
		  
		function sinIn(t, b, c, d)
		return -c * cos(t / d * (pi / 2)) + c + b
		end
		  
		function sinOut(t, b, c, d)
		return c * sin(t / d * (pi / 2)) + b
		end
		  
		function sinInOut(t, b, c, d)
		return -c / 2 * (cos(pi * t / d) - 1) + b
		end
		  
		function sinOutIn(t, b, c, d)
		if t < d / 2 then
			return sinOut(t * 2, b, c / 2, d)
		else
			return sinIn((t * 2) -d, b + c / 2, c / 2, d)
		end
		end
		  
		function expIn(t, b, c, d)
		if t == 0 then
			return b
		else
			return c * pow(2, 10 * (t / d - 1)) + b - c * 0.001
		end
		end
		  
		function expOut(t, b, c, d)
		if t == d then
			return b + c
		else
			return c * 1.001 * (-pow(2, -10 * t / d) + 1) + b
		end
		end
		  
		function expInOut(t, b, c, d)
		if t == 0 then return b end
		if t == d then return b + c end
		t = t / d * 2
		if t < 1 then
			return c / 2 * pow(2, 10 * (t - 1)) + b - c * 0.0005
		else
			t = t - 1
			return c / 2 * 1.0005 * (-pow(2, -10 * t) + 2) + b
		end
		end
		  
		function expOutIn(t, b, c, d)
		if t < d / 2 then
			return expOut(t * 2, b, c / 2, d)
		else
			return expIn((t * 2) - d, b + c / 2, c / 2, d)
		end
		end
		  
		function circIn(t, b, c, d)
		t = t / d
		return(-c * (sqrt(1 - pow(t, 2)) - 1) + b)
		end
		  
		function circOut(t, b, c, d)
		t = t / d - 1
		return(c * sqrt(1 - pow(t, 2)) + b)
		end
		  
		function circInOut(t, b, c, d)
		t = t / d * 2
		if t < 1 then
			return -c / 2 * (sqrt(1 - t * t) - 1) + b
		else
			t = t - 2
			return c / 2 * (sqrt(1 - t * t) + 1) + b
		end
		end
		  
		function circOutIn(t, b, c, d)
		if t < d / 2 then
			return circOut(t * 2, b, c / 2, d)
		else
			return circIn((t * 2) - d, b + c / 2, c / 2, d)
		end
		end

		--[[elastic easing additional params:
		a: amplitude
		p: period
		]]
		function elasticIn(t, b, c, d, a, p)
		contract('rn,rn,rn,rn,n,n')
		if t == 0 then return b end
		t = t / d
		if t == 1  then return b + c end
		if not p then p = d * 0.3 end
		local s
		if not a or a < abs(c) then
			a = c
			s = p / 4
		else
			s = p / (2 * pi) * asin(c/a)
		end
		t = t - 1
		return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
		end
		  
		function elasticOut(t, b, c, d, a, p)
		contract('rn,rn,rn,rn,n,n')
		if t == 0 then return b end
		t = t / d
		if t == 1 then return b + c end
		if not p then p = d * 0.3 end
		local s
		if not a or a < abs(c) then
			a = c
			s = p / 4
		else
			s = p / (2 * pi) * asin(c/a)
		end
		return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) + c + b
		end
		  
		function elasticInOut(t, b, c, d, a, p)
		contract('rn,rn,rn,rn,n,n')
		if t == 0 then return b end
		t = t / d * 2
		if t == 2 then return b + c end
		if not p then p = d * (0.3 * 1.5) end
		if not a then a = 0 end
		local s
		if not a or a < abs(c) then
			a = c
			s = p / 4
		else
			s = p / (2 * pi) * asin(c / a)
		end
		if t < 1 then
			t = t - 1
			return -0.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
		else
			t = t - 1
			return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p ) * 0.5 + c + b
		end
		end
		  
		function elasticOutIn(t, b, c, d, a, p)
		contract('rn,rn,rn,rn,n,n')
		if t < d / 2 then
			return elasticOut(t * 2, b, c / 2, d, a, p)
		else
			return elasticIn((t * 2) - d, b + c / 2, c / 2, d, a, p)
		end
		end
		  
		--back params:
		--  s: strength (?)
		function backIn(t, b, c, d, s)
		contract('rn,rn,rn,rn,n')
		if not s then s = 1.70158 end
		t = t / d
		return c * t * t * ((s + 1) * t - s) + b
		end
		  
		function backOut(t, b, c, d, s)
		contract('rn,rn,rn,rn,n')
		if not s then s = 1.70158 end
		t = t / d - 1
		return c * (t * t * ((s + 1) * t + s) + 1) + b
		end
		  
		function backInOut(t, b, c, d, s)
		contract('rn,rn,rn,rn,n')
		if not s then s = 1.70158 end
		s = s * 1.525
		t = t / d * 2
		if t < 1 then
			return c / 2 * (t * t * ((s + 1) * t - s)) + b
		else
			t = t - 2
			return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
		end
		end
		  
		function backOutIn(t, b, c, d, s)
		contract('rn,rn,rn,rn,n')
		if t < d / 2 then
			return backOut(t * 2, b, c / 2, d, s)
		else
			return backIn((t * 2) - d, b + c / 2, c / 2, d, s)
		end
		end
		  
		function bounceOut(t, b, c, d)
		t = t / d
		if t < 1 / 2.75 then
			return c * (7.5625 * t * t) + b
		elseif t < 2 / 2.75 then
			t = t - (1.5 / 2.75)
			return c * (7.5625 * t * t + 0.75) + b
		elseif t < 2.5 / 2.75 then
			t = t - (2.25 / 2.75)
			return c * (7.5625 * t * t + 0.9375) + b
		else
			t = t - (2.625 / 2.75)
			return c * (7.5625 * t * t + 0.984375) + b
		end
		end
		  
		function bounceIn(t, b, c, d)
		return c - bounceOut(d - t, 0, c, d) + b
		end
		  
		function bounceInOut(t, b, c, d)
		if t < d / 2 then
			return bounceIn(t * 2, 0, c, d) * 0.5 + b
		else
			return bounceOut(t * 2 - d, 0, c, d) * 0.5 + c * .5 + b
		end
		end
		  
		function bounceOutIn(t, b, c, d)
		if t < d / 2 then
			return bounceOut(t * 2, b, c / 2, d)
		else
			return bounceIn((t * 2) - d, b + c / 2, c / 2, d)
		end
		end

		--pct: when change occurs, from 0-1
		function abrupt(t, b, c, d, pct)
		contract('rn,rn,rn,rn,n')
		pct = pct or 0.5
		if t/d < pct then
			return b
		else
			return b + c
		end
		end
	**/
}
