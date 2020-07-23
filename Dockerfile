FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env

WORKDIR /app

# Copy project and restore as distinct layers
COPY . ./
RUN dotnet restore

# Copy everything else and build

RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/sdk:3.1
WORKDIR /app
COPY --from=build-env /app/out .

# Exposing the default port
EXPOSE 7171

ENTRYPOINT ["dotnet"]
