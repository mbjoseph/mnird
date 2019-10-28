
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mnird

(M)achine learning + (N)EON + (I)nstrumentation + literature (R)eview
for + bio(D)iversity

[![Build
Status](https://travis-ci.com/mbjoseph/mnird.svg?branch=master)](https://travis-ci.com/mbjoseph/mnird)
[![Codecov test
coverage](https://codecov.io/gh/mbjoseph/mnird/branch/master/graph/badge.svg)](https://codecov.io/gh/mbjoseph/mnird?branch=master)

This is a set of utility functions to help with the literature review
and content analysis for a project evaluating biodiversity measurement
at NEON sites using instrumentation and machine learning.

## Installation

``` r
remotes::install_github("mbjoseph/mnird")
```

## Getting started

### Get abstracts

To pull abstracts for all papers in a `.bib` file:

``` r
library(mnird)
library(topicmodels)
library(tidyverse)
library(tidytext)

# you can replace this with a path to a local file
path_to_bib <- system.file("extdata",
                              "neon-biodiversity-instrumentation-ml.bib",
                              package = "mnird")
```

A `.bib` file contains entries like:

``` 

@article{fricker_convolutional_2019,
    title = {A {Convolutional} {Neural} {Network} {Classifier} {Identifies} {Tree} {Species} in {Mixed}-{Conifer} {Forest} from {Hyperspectral} {Imagery}},
    volume = {11},
    issn = {2072-4292},
    url = {https://www.mdpi.com/2072-4292/11/19/2326},
    doi = {10.3390/rs11192326},
    language = {en},
    number = {19},
    urldate = {2019-10-16},
    journal = {Remote Sensing},
    author = {Fricker, Geoffrey A. and Ventura, Jonathan D. and Wolf, Jeffrey A. and North, Malcolm P. and Davis, Frank W. and Franklin, Janet},
    month = oct,
    year = {2019},
    pages = {2326}
}

@article{zhou_bayesian_2017,
    title = {Bayesian and {Classical} {Machine} {Learning} {Methods}: {A} {Comparison} for {Tree} {Species} {Classification} with {LiDAR} {Waveform} {Signatures}},
    volume = {10},
    issn = {2072-4292},
    shorttitle = {Bayesian and {Classical} {Machine} {Learning} {Methods}},
    url = {http://www.mdpi.com/2072-4292/10/1/39},
    doi = {10.3390/rs10010039},
    language = {en},
    number = {2},
    urldate = {2019-10-16},
    journal = {Remote Sensing},
    author = {Zhou, Tan and Popescu, Sorin and Lawing, A. and Eriksson, Marian and Strimbu, Bogdan and Bürkner, Paul},
    month = dec,
    year = {2017},
    pages = {39}
}

@article{sumsion_remote_2019,
    title = {Remote sensing tree classification with a multilayer perceptron},
    volume = {7},
    issn = {2167-8359},
    url = {https://peerj.com/articles/6101},
    doi = {10.7717/peerj.6101},
    language = {en},
    urldate = {2019-10-16},
    journal = {PeerJ},
    author = {Sumsion, G Rex and Bradshaw, Michael S. and Hill, Kimball T. and Pinto, Lucas D.G. and Piccolo, Stephen R.},
    month = feb,
    year = {2019},
    pages = {e6101}
}

@article{marconi_data_2019,
    title = {A data science challenge for converting airborne remote sensing data into ecological information},
    volume = {6},
    issn = {2167-8359},
    url = {https://peerj.com/articles/5843},
    doi = {10.7717/peerj.5843},
    language = {en},
    urldate = {2019-10-16},
    journal = {PeerJ},
    author = {Marconi, Sergio and Graves, Sarah J. and Gong, Dihong and Nia, Morteza Shahriari and Le Bras, Marion and Dorr, Bonnie J. and Fontana, Peter and Gearhart, Justin and Greenberg, Craig and Harris, Dave J. and Kumar, Sugumar Arvind and Nishant, Agarwal and Prarabdh, Joshi and Rege, Sundeep U. and Bohlman, Stephanie Ann and White, Ethan P. and Wang, Daisy Zhe},
    month = feb,
    year = {2019},
    pages = {e5843}
}

@article{zou_hyperspectral_2019,
    title = {Hyperspectral tree crown classification using the multiple instance adaptive cosine estimator},
    volume = {7},
    issn = {2167-8359},
    url = {https://peerj.com/articles/6405},
    doi = {10.7717/peerj.6405},
    language = {en},
    urldate = {2019-10-16},
    journal = {PeerJ},
    author = {Zou, Sheng and Gader, Paul and Zare, Alina},
    month = feb,
    year = {2019},
    pages = {e6405}
}

@article{gewali_gaussian_2019,
    title = {Gaussian {Processes} for {Vegetation} {Parameter} {Estimation} from {Hyperspectral} {Data} with {Limited} {Ground} {Truth}},
    volume = {11},
    issn = {2072-4292},
    url = {https://www.mdpi.com/2072-4292/11/13/1614},
    doi = {10.3390/rs11131614},
    language = {en},
    number = {13},
    urldate = {2019-10-16},
    journal = {Remote Sensing},
    author = {Gewali, Utsav B. and Monteiro, Sildomar T. and Saber, Eli},
    month = jul,
    year = {2019},
    pages = {1614}
}

@article{schooler_lidar_2019,
    title = {Lidar {Prediction} of {Small} {Mammal} {Diversity} in {Wisconsin}, {USA}},
    volume = {11},
    issn = {2072-4292},
    url = {https://www.mdpi.com/2072-4292/11/19/2222},
    doi = {10.3390/rs11192222},
    language = {en},
    number = {19},
    urldate = {2019-10-16},
    journal = {Remote Sensing},
    author = {Schooler, Sarah L. and Zald, Harold S. J.},
    month = sep,
    year = {2019},
    pages = {2222}
}

@article{shahriari_nia_impact_2015,
    title = {Impact of atmospheric correction and image filtering on hyperspectral classification of tree species using support vector machine},
    volume = {9},
    issn = {1931-3195},
    url = {http://remotesensing.spiedigitallibrary.org/article.aspx?doi=10.1117/1.JRS.9.095990},
    doi = {10.1117/1.JRS.9.095990},
    language = {en},
    number = {1},
    urldate = {2019-10-16},
    journal = {Journal of Applied Remote Sensing},
    author = {Shahriari Nia, Morteza and Wang, Daisy Zhe and Bohlman, Stephanie Ann and Gader, Paul and Graves, Sarah J. and Petrovic, Milenko},
    month = nov,
    year = {2015},
    pages = {095990}
}

@article{jiao_multiple_2018,
    title = {Multiple instance hybrid estimator for hyperspectral target characterization and sub-pixel target detection},
    volume = {146},
    issn = {09242716},
    url = {https://linkinghub.elsevier.com/retrieve/pii/S0924271618302314},
    doi = {10.1016/j.isprsjprs.2018.08.012},
    language = {en},
    urldate = {2019-10-16},
    journal = {ISPRS Journal of Photogrammetry and Remote Sensing},
    author = {Jiao, Changzhe and Chen, Chao and McGarvey, Ronald G. and Bohlman, Stephanie and Jiao, Licheng and Zare, Alina},
    month = dec,
    year = {2018},
    pages = {235--250}
}

@article{anderson_ccb-id_2018,
    title = {The {CCB}-{ID} approach to tree species mapping with airborne imaging spectroscopy},
    volume = {6},
    issn = {2167-8359},
    url = {https://peerj.com/articles/5666},
    doi = {10.7717/peerj.5666},
    language = {en},
    urldate = {2019-10-16},
    journal = {PeerJ},
    author = {Anderson, Christopher B.},
    month = oct,
    year = {2018},
    pages = {e5666}
}

@article{ayrey_use_2018,
    title = {The {Use} of {Three}-{Dimensional} {Convolutional} {Neural} {Networks} to {Interpret} {LiDAR} for {Forest} {Inventory}},
    volume = {10},
    issn = {2072-4292},
    url = {http://www.mdpi.com/2072-4292/10/4/649},
    doi = {10.3390/rs10040649},
    language = {en},
    number = {4},
    urldate = {2019-10-16},
    journal = {Remote Sensing},
    author = {Ayrey, Elias and Hayes, Daniel},
    month = apr,
    year = {2018},
    pages = {649}
}

@inproceedings{gewali_multitask_2016,
    title = {Multitask learning of vegetation biochemistry from hyperspectral data},
    isbn = {978-1-5090-0608-3},
    url = {http://ieeexplore.ieee.org/document/8071800/},
    doi = {10.1109/WHISPERS.2016.8071800},
    urldate = {2019-10-16},
    publisher = {IEEE},
    author = {Gewali, Utsav B. and Monteiro, Sildomar T.},
    month = aug,
    year = {2016},
    pages = {1--5}
}

@article{diao_complex_2019,
    title = {Complex network-based time series remote sensing model in monitoring the fall foliage transition date for peak coloration},
    volume = {229},
    issn = {00344257},
    url = {https://linkinghub.elsevier.com/retrieve/pii/S0034425719301889},
    doi = {10.1016/j.rse.2019.05.003},
    language = {en},
    urldate = {2019-10-16},
    journal = {Remote Sensing of Environment},
    author = {Diao, Chunyuan},
    month = aug,
    year = {2019},
    pages = {179--192}
}

@article{weinstein_individual_2019,
    title = {Individual {Tree}-{Crown} {Detection} in {RGB} {Imagery} {Using} {Semi}-{Supervised} {Deep} {Learning} {Neural} {Networks}},
    volume = {11},
    issn = {2072-4292},
    url = {https://www.mdpi.com/2072-4292/11/11/1309},
    doi = {10.3390/rs11111309},
    language = {en},
    number = {11},
    urldate = {2019-10-17},
    journal = {Remote Sensing},
    author = {Weinstein, Ben G. and Marconi, Sergio and Bohlman, Stephanie and Zare, Alina and White, Ethan},
    month = jun,
    year = {2019},
    pages = {1309}
}

@article{weinstein_geographic_2019,
    title = {Geographic {Generalization} in {Airborne} {RGB} {Deep} {Learning} {Tree} {Detection}},
    url = {http://biorxiv.org/lookup/doi/10.1101/790071},
    doi = {10.1101/790071},
    abstract = {Tree detection is a fundamental task in remote sensing for forestry and ecosystem ecology applications. While many individual tree segmentation algorithms have been proposed, the development and testing of these algorithms is typically site specific, with few methods evaluated against data from multiple forest types simultaneously. This makes it difficult to determine the generalization of proposed approaches, and limits tree detection at broad scales. Using data from the National Ecological Observatory Network we extend a recently developed semi-supervised deep learning algorithm to include data from a range of forest types, determine whether information from one forest can be used for tree detection in other forests, and explore the potential for building a universal tree detection algorithm. We find that the deep learning approach works well for overstory tree detection across forest conditions, outperforming conventional LIDAR-only methods in all forest types. Performance was best in open oak woodlands and worst in alpine forests. When models were fit to one forest type and used to predict another, performance generally decreased, with better performance when forests were more similar in structure. However, when models were pretrained on data from other sites and then fine-tuned using a small amount of hand-labeled data from the evaluation site, they performed similarly to local site models. Most importantly, a universal model fit to data from all sites simultaneously performed as well or better than individual models trained for each local site. This result suggests that RGB tree detection models that can be applied to a wide array of forest types at broad scales should be possible.},
    urldate = {2019-10-17},
    journal = {bioRxiv},
    author = {Weinstein, Ben. G. and Marconi, Sergio and Bohlman, Stephanie A. and Zare, Alina and White, Ethan P.},
    month = oct,
    year = {2019}
}

@article{marconi_rethinking_2019,
    title = {Rethinking the fundamental unit of ecological remote sensing: {Estimating} individual level plant traits at scale},
    shorttitle = {Rethinking the fundamental unit of ecological remote sensing},
    url = {http://biorxiv.org/lookup/doi/10.1101/556472},
    doi = {10.1101/556472},
    abstract = {Functional ecology has increasingly focused on describing ecological communities based on their traits (measurable features affecting individuals’ fitness and performance). Analyzing trait distributions within and among forests could significantly improve understanding of community composition and ecosystem function. Historically, data on trait distributions in ecosystems are generated by (1) collecting few leaves from a small number of trees, which suffers from limited sampling but produces information at the fundamental ecological unit (the individual); or (2) using remote sensing images to infer traits, producing information continuously across large regions, but as plots (containing multiple trees of different species) or pixels, not individuals. Remote sensing methods that identify individual trees and estimate their traits would provide the benefits of both approaches, producing continuous large-scale data linked to biological individuals. We used data from the National Ecological Observatory Network (NEON) to develop a method to scale up functional traits measured on 160 trees to the millions of trees within the spatial extent of two NEON sites. The pipeline consists of three stages: 1) image segmentation, to identify individual trees and estimate their structural traits; 2) ensemble of models to infer leaf mass area (LMA), nitrogen, carbon, and phosphorus content using hyperspectral signatures; and 3) making predictions for segmented crowns for the full remote sensing footprint at the NEON sites.,Nitrogen, LMA and phosphorus models R

            values ranged from 0.50 to 0.75 on held out test data. The ensemble approach performed better than single partial least squares generalized linear regressions models. Models for carbon performed poorly compared to other traits (R

            of 0.22). Crown segmentation produced the highest uncertainty in the pipeline, generally due to over-segmentation. Despite this, crown traits predictions performed significantly better than comparable 1m

            pixel predictions, resulting in improvement of R

            on test data of between 0.07 to 0.20 points.,We used the pipeline to produce individual level trait data for ∼5 million individual crowns, covering a total extent of ∼360 km

            . This large data set allows testing ecological questions on landscapes scales, for example revealing leaf chemical traits were correlated with physical traits and environmental conditions including height and elevation.},
    urldate = {2019-10-17},
    journal = {bioRxiv},
    author = {Marconi, Sergio and Graves, Sarah J. and Weinstein, Ben. G. and Bohlman, Stephanie and White, Ethan P.},
    month = sep,
    year = {2019}
}

@article{dalponte_individual_2019,
    title = {Individual tree crown delineation and tree species classification with hyperspectral and {LiDAR} data},
    volume = {6},
    issn = {2167-8359},
    url = {https://peerj.com/articles/6227},
    doi = {10.7717/peerj.6227},
    language = {en},
    urldate = {2019-10-17},
    journal = {PeerJ},
    author = {Dalponte, Michele and Frizzera, Lorenzo and Gianelle, Damiano},
    month = jan,
    year = {2019},
    pages = {e6227}
}
```

To get the abstracts for each entry:

``` r
abstracts <- get_abstracts(path_to_bib)
#> Registered S3 method overwritten by 'crul':
#>   method                 from
#>   as.character.form_file httr
#> Registered S3 method overwritten by 'hoardr':
#>   method           from
#>   print.cache_info httr
abstracts
#> # A tibble: 17 x 2
#>    doi                    abstract                                         
#>    <chr>                  <chr>                                            
#>  1 10.3390/rs11192326     <jats:p>In this study, we automate tree species …
#>  2 10.3390/rs10010039     <NA>                                             
#>  3 10.7717/peerj.6101     <jats:p>To accelerate scientific progress on rem…
#>  4 10.7717/peerj.5843     <jats:p>Ecology has reached the point where data…
#>  5 10.7717/peerj.6405     <jats:p>Tree species classification using hypers…
#>  6 10.3390/rs11131614     <jats:p>An important application of airborne- an…
#>  7 10.3390/rs11192222     <jats:p>Vegetation structure is a crucial compon…
#>  8 10.1117/1.JRS.9.095990 <NA>                                             
#>  9 10.1016/j.isprsjprs.2… <NA>                                             
#> 10 10.7717/peerj.5666     "<jats:sec>\n<jats:title>Background</jats:title>…
#> 11 10.3390/rs10040649     <NA>                                             
#> 12 10.1109/WHISPERS.2016… <NA>                                             
#> 13 10.1016/j.rse.2019.05… <NA>                                             
#> 14 10.3390/rs11111309     <jats:p>Remote sensing can transform the speed, …
#> 15 10.1101/790071         <jats:title>Abstract</jats:title><jats:p>Tree de…
#> 16 10.1101/556472         <jats:title>Abstract</jats:title><jats:p>Functio…
#> 17 10.7717/peerj.6227     <jats:p>An international data science challenge,…
```

### Perform Latent Dirichlet Allocation to identify topics

First, you need a document-term matrix:

``` r
dt_mat <- get_document_terms(abstracts)
#> Joining, by = "word"
```

Then you can use `topicmodels::LDA` to perform LDA, and visualize the
results. Note that in this case, the topics are nearly identical, since
many of the papers are on the same topic…

``` r
lda <- LDA(dt_mat, k = 2, control = list(seed = 1234))

lda_df <- tidy(lda, matrix = "beta")

top_terms <- lda_df %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

top_terms %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ paste("Topic ", topic), scales = "free") +
  coord_flip() +
  scale_x_reordered()
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />
