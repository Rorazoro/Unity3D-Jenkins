echo "Archiving Builds"

cd ..
MD %ARTIFACTS%
cd Builds

for /D %%d in (*.*) do (
    %ZIP% a -tzip "%%d.zip" "%%d"
    MOVE "%%d.zip" %ARTIFACTS%
)