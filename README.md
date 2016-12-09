## Jupyter Notebook

### Packages

* Numpy
* Scipy
* Scikit-learn
* Matplotlib
* SymPy
* Pandas
* NLTK
* Tensorflow
* Keras
* IRuby
* RISE
* Thrift

### Usage

      docker run -d --name jupyter -p 8888:8888 -v `pwd`:/notebook hjoest/jupyter
      docker logs jupyter 2>&1 | grep running

Open the displayed URL in a browser.
