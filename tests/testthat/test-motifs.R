test_that("count_motifs works", {
  withr::local_seed(123)

  gnp <- sample_gnp(10000, 4 / 10000, directed = TRUE)

  mno <- count_motifs(gnp)

  mno0 <- count_motifs(gnp, cut.prob = c(1 / 3, 0, 0))
  mno1 <- count_motifs(gnp, cut.prob = c(0, 0, 1 / 3))
  mno2 <- count_motifs(gnp, cut.prob = c(0, 1 / 3, 0))
  expect_equal(
    c(mno0 / mno, mno1 / mno, mno2 / mno),
    c(0.654821903845065, 0.666289144345659, 0.668393831285275)
  )

  mno3 <- count_motifs(gnp, cut.prob = c(0, 1 / 3, 1 / 3))
  mno4 <- count_motifs(gnp, cut.prob = c(1 / 3, 0, 1 / 3))
  mno5 <- count_motifs(gnp, cut.prob = c(1 / 3, 1 / 3, 0))
  expect_equal(
    c(mno3 / mno, mno4 / mno, mno5 / mno),
    c(0.443959957465819, 0.441952797125797, 0.446004870037941)
  )
})

test_that("motifs works", {
  withr::local_seed(123)
  gnp <- sample_gnp(10000, 4 / 10000, directed = TRUE)

  m <- motifs(gnp)

  m0 <- motifs(gnp, cut.prob = c(1 / 3, 0, 0))
  m1 <- motifs(gnp, cut.prob = c(0, 1 / 3, 0))
  m2 <- motifs(gnp, cut.prob = c(0, 0, 1 / 3))
  expect_equal(m0 / m, c(NA, NA, 0.653972107372707, NA, 0.653993015279859, 0.612244897959184, 0.657514670174019, 0.63013698630137, NaN, 0.538461538461538, NaN, 0.565217391304348, NaN, NaN, NaN, NaN))
  expect_equal(m1 / m, c(NA, NA, 0.669562138856225, NA, 0.66808158454082, 0.73469387755102, 0.670819000404694, 0.657534246575342, NaN, 0.769230769230769, NaN, 0.739130434782609, NaN, NaN, NaN, NaN))
  expect_equal(m2 / m, c(NA, NA, 0.666451718949538, NA, 0.665291458452201, 0.591836734693878, 0.666683528935654, 0.671232876712329, NaN, 0.753846153846154, NaN, 0.565217391304348, NaN, NaN, NaN, NaN))

  m3 <- motifs(gnp, cut.prob = c(0, 1 / 3, 1 / 3))
  m4 <- motifs(gnp, cut.prob = c(1 / 3, 1 / 3, 0))
  m5 <- motifs(gnp, cut.prob = c(1 / 3, 1 / 3, 0))
  expect_equal(m3 / m, c(NA, NA, 0.445611905574732, NA, 0.442789875290769, 0.448979591836735, 0.444695973290166, 0.424657534246575, NaN, 0.369230769230769, NaN, 0.608695652173913, NaN, NaN, NaN, NaN))

  expect_equal(m4 / m, c(NA, NA, 0.439251981944392, NA, 0.439284975327761, 0.73469387755102, 0.445088021044112, 0.465753424657534, NaN, 0.630769230769231, NaN, 0.565217391304348, NaN, NaN, NaN, NaN))

  expect_equal(m5 / m, c(NA, NA, 0.439985332979302, NA, 0.440288166730411, 0.346938775510204, 0.44159753136382, 0.452054794520548, NaN, 0.323076923076923, NaN, 0.347826086956522, NaN, NaN, NaN, NaN))
})

test_that("sample_motifs works", {
  withr::local_seed(20041103)

  g <- make_graph(~ A - B - C - A - D - E - F - D - C - F)
  n <- vcount(g)

  motif_count <- sample_motifs(g)
  expect_true(0 <= motif_count && motif_count <= n * (n - 1) * (n - 2) / 6)

  motif_count_letters <- sample_motifs(g, sample = c("C", "D", "E", "F"))
  expect_true(0 <= motif_count_letters && motif_count_letters <= n * (n - 1) * (n - 2) / 6)

  motif_count_all <- sample_motifs(g, sample = V(g))
  expect_true(0 <= motif_count_all && motif_count_all <= n * (n - 1) * (n - 2) / 6)
})

test_that("dyad_census works", {
  g1 <- make_ring(10)
  expect_warning(dc1 <- dyad_census(g1), "directed")
  expect_equal(dc1, list(mut = 10, asym = 0, null = 35))

  g2 <- make_ring(10, directed = TRUE, mutual = TRUE)
  dc2 <- dyad_census(g2)
  expect_equal(dc2, list(mut = 10, asym = 0, null = 35))

  g3 <- make_ring(10, directed = TRUE, mutual = FALSE)
  dc3 <- dyad_census(g3)
  expect_equal(dc3, list(mut = 0, asym = 10, null = 35))
})

test_that("dyad_census works with celegansneural", {
  ce <- simplify(read_graph(gzfile("celegansneural.gml.gz"), format = "gml"))
  dc <- dyad_census(ce)

  expect_equal(dc, list(mut = 197, asym = 1951, null = 41808))
  expect_equal(sum(which_mutual(ce)), dc$mut * 2)
  expect_equal(
    ecount(as_undirected(ce, mode = "collapse")) - dc$mut,
    dc$asym
  )
  expect_equal(sum(unlist(dc)), vcount(ce) * (vcount(ce) - 1) / 2)
})
