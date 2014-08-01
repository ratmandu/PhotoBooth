#include "settings.h"

Settings::Settings(QObject *parent) :
  QObject(parent)
{
  m_settings = new QSettings();
}

Settings::~Settings()
{
  m_settings->deleteLater();
}

void Settings::setValue(const QString &key, const QVariant &value)
{
  m_settings->setValue(key, value);
  m_settings->sync();
}

QVariant Settings::getValue(const QString &key, const QVariant &defaultValue) const
{
  return m_settings->value(key, defaultValue);
}

void Settings::setString(const QString &key, const QString &value)
{
  m_settings->setValue(key, value);
  m_settings->sync();
}

QString Settings::getString(const QString &key, const QString &defaultValue) const
{
  return m_settings->value(key, defaultValue).toString();
}

void Settings::setBool(const QString &key, const bool &value)
{
  m_settings->setValue(key, value);
  m_settings->sync();
}

bool Settings::getBool(const QString &key, const bool &defaultValue) const
{
  return m_settings->value(key, defaultValue).toBool();
}

void Settings::setInt(const QString &key, const int &value)
{
  m_settings->setValue(key, value);
  m_settings->sync();
}

int Settings::getInt(const QString &key, const int &defaultValue) const
{
  return m_settings->value(key, defaultValue).toInt();
}
