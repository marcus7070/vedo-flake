{
  lib
  , src
  , buildPythonPackage
  , vtk
  , numpy
  , python
}:

buildPythonPackage rec {
  pname = "vedo";
  version = "git-" + builtins.substring 0 7 src.rev;

  inherit src;

  propagatedBuildInputs = [
    numpy
    vtk
  ];

  postPatch = ''
    # Discovery of 'vtk' in setuptools is not working properly, due to a missing
    # .egg-info in the vtk package. It does however import and run just fine.
    substituteInPlace setup.py --replace '"vtk", ' ""
  '';

  # preInstall = ''
  #   echo $PYTHONPATH
  #   export PYTHONPATH=$PYTHONPATH:${vtk}/${python.sitePackages}
  #   echo ""
  #   echo "now with vtk sitePackages added:"
  #   echo $PYTHONPATH
  #   echo ${python.pythonForBuild.interpreter}
  #   ${python.pythonForBuild.interpreter} -c "import vtk;" && echo "successfully imported vtk"
  #   ${python.pythonForBuild.interpreter} -m pip show vtk
  # '';

  meta = with lib; {
    description = "A python module for scientific analysis of 3D objects based on VTK";
    homepage = "https://vedo.embl.es/";
    license = licenses.mit;
    maintainers = with maintainers; [ marcus7070 ];
  };
}
