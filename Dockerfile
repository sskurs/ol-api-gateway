FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 5001

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["ol-api-gateway.csproj", "."]
RUN dotnet restore "./ol-api-gateway.csproj"
COPY . .
RUN dotnet build "ol-api-gateway.csproj" -c Release -o /app/build
RUN dotnet publish "ol-api-gateway.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "ol-api-gateway.dll"] 