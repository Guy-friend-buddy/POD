# POD
Calculate 2D POD

What is POD ?

The Proper Orthogonal Decomposition (POD) method, also known as the Karhunen-Loeve expansion or the Principal Component Analysis (PCA) method, is a mathematical technique that is used to extract the most important features or patterns from a set of data, known as snapshots. The POD method is commonly used in the field of computational fluid dynamics, structural mechanics, and other areas of physics and engineering to reduce the dimensionality of large-scale systems.

The POD method works by projecting the snapshots onto a lower-dimensional subspace, where the most important features of the data are retained and the less important features are discarded. This is done by constructing an orthonormal basis for the subspace, which is made up of the eigenvectors of the covariance matrix of the snapshots. The eigenvectors are ordered according to the magnitude of their corresponding eigenvalues, which represent the amount of variance in the data that is captured by each eigenvector.

The POD method can be used to reduce the dimensionality of a system by retaining only the eigenvectors that correspond to the largest eigenvalues, which capture the most important features of the data. The reduced-order models obtained from POD can be used for a variety of purposes, such as model reduction, data compression, and feature extraction
