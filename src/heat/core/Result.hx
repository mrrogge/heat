package heat.core;

enum Result<TSuccess, TFailure> {
    Ok(result:TSuccess);
    Err(err:TFailure);
}