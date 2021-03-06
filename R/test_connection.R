test_connection <- function(master = master,
                config = config,
                app_name,
                version,
                hadoop_version ,
                extensions) {
  sc <- new_test_connection(list(
    # spark_connection
    master = master,
    config = config,
    state = new.env()
    # test_connection
  ))

  sc$state$spark_context <- test_jobj_create(sc)
  sc$state$hive_context <- test_jobj_create(sc)
  sc$state$open <- TRUE
  sc
}

#' @export
spark_log.test_connection <- function(sc, n = 100, filter = NULL, ...) {
}

#' @export
spark_web.test_connection <- function(sc, ...) {
}

#' @export
connection_is_open.test_connection <- function(sc) {
  sc$state$open
}

#' @export
spark_disconnect.test_connection <- function(sc, ...) {
  sc$state$open <- FALSE
}

#' @export
invoke_static.test_connection <- function(sc, class, method, ...) {
}

#' @export
invoke_new.test_connection <- function(sc, class, ...) {
}

#' @export
initialize_connection.test_connection <- function(sc) {
  sc
}

test_jobj_create <- function(sc) {
  structure(
    list(
      connection = sc
    ),
    class = c("test_jobj", "spark_jobj")
  )
}

#' @export
invoke.test_jobj <- function(jobj, method, ...) {
  if (method == "version")
    "1.0.0"
  else
    test_jobj_create(jobj$connection)
}

#' @export
invoke_static.test_connection <- function(sc, class, method, ...) {
  test_jobj_create(sc)
}

#' @export
invoke_new.test_connection <- function(sc, class, ...) {
  test_jobj_create(sc)
}

#' @export
print_jobj.test_connection <- function(sc, jobj, ...) {
}

#' @export
sdf_import.test_connection <- function(x, sc, ...) {
  x
}

#' @export
sdf_copy_to.test_connection <- function(sc, x, ...) {
  x
}

#' @export
create_hive_context.test_connection <- function(sc) {
  test_jobj_create(sc)
}

new_test_connection <- function(scon) {
  new_spark_connection(scon, class = "test_connection")
}
