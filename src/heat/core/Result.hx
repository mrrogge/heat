package heat.core;

@:using(heat.core.Result.ResultTools)
enum Result<TSuccess, TFailure> {
	Ok(result:TSuccess);
	Err(err:TFailure);
}

class ResultTools {
	public static function all<TSuccess, TFailure>(cls:Enum<Result<TSuccess, TFailure>>,
			results:Array<Result<TSuccess, TFailure>>):Result<Array<TSuccess>, TFailure> {
		final successArray:Array<TSuccess> = [];
		for (result in results) {
			switch (result) {
				case Ok(result):
					{
						successArray.push(result);
					}
				case Err(err):
					{
						return Err(err);
					}
			}
		}
		return Ok(successArray);
	}

	public static function sure<TSuccess, TFailure>(result:Result<TSuccess, TFailure>):TSuccess {
		return switch (result) {
			case Err(err):
				{
					throw new haxe.Exception('Unexpected failure: ${err}');
				}
			case Ok(result): result;
		}
	}
}
