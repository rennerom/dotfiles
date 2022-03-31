# Install Versions of R
https://docs.rstudio.com/resources/install-r-source/

Install required dependancies

`sudo apt-get build-dep r-base`

Set whatever version

`export R_VERSION=4.0.5`

Download and extract

```bash
curl -O https://cran.rstudio.com/src/base/R-4/R-${R_VERSION}.tar.gz
tar -xzvf R-${R_VERSION}.tar.gz
cd R-${R_VERSION}
```

Build and install R

```bash
./configure \
    --prefix=/opt/R/${R_VERSION} \
    --enable-memory-profiling \
    --enable-R-shlib \
    --with-blas \
    --with-lapack

make
sudo make install
```

Check R installation
```bash
/opt/R/${R_VERSION}/bin/R --version
```
