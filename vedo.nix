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

  meta = with lib; {
    description = "A python module for scientific analysis of 3D objects based on VTK";
    homepage = "https://vedo.embl.es/";
    license = licenses.mit;
    maintainers = with maintainers; [ marcus7070 ];
  };
}
