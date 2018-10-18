FROM scriptandgo/android:20181018

RUN apt-get update -qq && apt-get install gnupg wget bzip2 libzip4 -y && apt install -y apt-transport-https
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb https://download.mono-project.com/repo/debian stable-stretch main" > /etc/apt/sources.list.d/mono-official-stable.list

RUN apt update -qq \
    && apt install mono-devel nuget msbuild referenceassemblies-pcl lynx -y \
    && apt install curl unzip openjdk-8-jdk openjdk-8-jre-headless -y

RUN wget https://jenkins.mono-project.com/view/Xamarin.Android/job/xamarin-android-linux/816/Azure/processDownloadRequest/xamarin-android/xamarin.android-oss_8.3.99.19_amd64.deb
RUN dpkg -i xamarin.android-oss_8.3.99.19_amd64.deb
RUN rm xamarin.android-oss_8.3.99.19_amd64.deb

RUN apt install git make -y
RUN git clone https://github.com/xamarin/jar2xml
RUN cd jar2xml && make && cp jar2xml.jar /usr/lib/xamarin.android/xbuild/Xamarin/Android/jar2xml.jar && cd ..
RUN rm -rf jar2xml

ENV ANDROID_SDK_PATH=$ANDROID_HOME
