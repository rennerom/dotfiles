# Install Versions of R

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
