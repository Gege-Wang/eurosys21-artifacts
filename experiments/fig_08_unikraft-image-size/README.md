# Comparing image sizes of Unikraft applications

<img align="right" src="../../plots/fig_08_unikraft-image-size.svg" width="300" />

From the paper, "the main advantage of unikernels over traditional operating
systems is their low resource consumption."  To demonstrate this, we evaluated
the image size of 4 representative applications in Unikraft.  This figure shows
that "Unikraft images are all under 2MBs for all of these applications."

This experiment tests 4 configurations:

 * Default configuration;
 * with Link-Time Optimizations (LTO);
 * with Dead Code Elimination (DCE); and,
 * with DCE and LTO,

against 4 Unikraft unikernels:

 * A simple "Hello World" C program;
 * NGINX;
 * SQlite; and,
 * Redis.

These image permutations are constructed using
[kraft](https://github.com/unikraft/kraft) via a [`Dockerfile`](/Dockerfile).

  N.B. You may need to set `UK_KRAFT_GITHUB_TOKEN` as a prefix to `make
  docker` in the top-level directory if you are rate-limited by kraft, e.g.:
  ```
  DOCKER_BUILD_EXTRA="--build-arg UK_KRAFT_GITHUB_TOKEN=<mytoken>" make docker-kraft
  ```

| Target             | Estimated time |
|--------------------|----------------|
| `make docker`      | 2m 24s         |
| `make helloworld`  | 2m 18s         |
| `make redis`       | 22m 48s        |
| `make sqlite`      | 20m 48s        |
| `make nginx`       | 27m 7s         |
