self: super: with self; {

  python27 = super.python27.override pythonOverrides;
  python27Packages = super.recurseIntoAttrs (python27.pkgs);
  python36 = super.python36.override pythonOverrides;
  python36Packages = super.recurseIntoAttrs (python36.pkgs);

  pythonOverrides = {
    packageOverrides = python-self: python-super: {
      flask-helloworld = pythonPackages.buildPythonPackage rec {
        name = "flask-hello-world-${version}";
        version = "0.1.0";

        src = fetchgit {
          url = "https://github.com/knedlsepp/flask-hello-world.git";
          rev = "dff5896234ce2bd7afa66134206f3403f2d94e38";
          sha256 = "0g350ikvnz1kzyb31z6363nvjgyfj5f75a2c1p008s18sv0blqr3";
        };
        propagatedBuildInputs = with pythonPackages; [
          flask
        ];
      };
      pytest-flask = pythonPackages.buildPythonPackage rec {
        name = "pytest-flask-${version}";
        version = "0.10.0";        src = pkgs.fetchurl {
          url = "mirror://pypi/p/pytest-flask/${name}.tar.gz";
          sha256 = "00vznyjfn6qszq6v551z53y9g4gqsjysxvyvbpwbdy1y0gwkcnic";
        };
        propagatedBuildInputs = with pythonPackages; [
          pytest
          werkzeug
          flask
        ];
      };
      flask-httpauth = pythonPackages.buildPythonPackage rec {
        name = "Flask-HTTPAuth-${version}";
        version = "3.2.3";
        src = pkgs.fetchurl {
          url = "mirror://pypi/f/flask-httpauth/${name}.tar.gz";
          sha256 = "13gff5w1mqpzm5nccyg02v3ifb9ifqh5k866cssjhghhg6msfjsz";
        };
        propagatedBuildInputs = with pythonPackages; [
          flask
        ];
      };
      flask-admin = pythonPackages.buildPythonPackage rec {
        name = "Flask-Admin-${version}";
        version = "1.5.0";
        src = pkgs.fetchurl {
          url = "mirror://pypi/f/flask-admin/${name}.tar.gz";
          sha256 = "1iabc9x540i1wgb97nr5xxrnblzzdkg69lw3gv6r7qi2kzcrcfpy";
        };
        propagatedBuildInputs = with pythonPackages; [
          flask
          wtforms
        ];
        doCheck = false;
      };
      sandman2 = pythonPackages.buildPythonPackage rec {
        name = "sandman2-${version}";
        version = "1.0.6";
        src = pkgs.fetchurl {
          url = "mirror://pypi/s/sandman2/${name}.tar.gz";
          sha256 = "0dk62iqkrphmf9c8vcjg5y1wcc3qqwnrbxl5bswknfmr453ncd7y";
        };
        patchPhase = ''
          substituteInPlace setup.py --replace "SQLAlchemy==1.1.0b3" "SQLAlchemy>=1.1.0b3"
        '';
        propagatedBuildInputs = with pythonPackages; [
          pytest-flask
          flask-httpauth
          flask-admin
          sqlalchemy
          flask_sqlalchemy
          pytestcov
        ];
      };
    };
  };
}
