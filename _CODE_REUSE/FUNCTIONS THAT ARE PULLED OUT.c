// FUNCTIONS THAT ARE PULLED OUT
// =============================

// Float and double are not supported as data types.
void DebugPrintf(const char* pFormat, ...)
{
  if (!m_Printer)
  {
    return;
  }

  int32_t iLength;
  va_list pArgs;
  va_start(pArgs, pFormat);
  iLength = vsnprintf((char*)m_pBuffer, m_iBufferSize, pFormat, pArgs);
  va_end(pArgs);

  iLength = Minimum2Signed(iLength, m_iBufferSize - 1); // -1 since vsnprintf ensures null termination
  if (iLength > 0)
  {
    m_Printer(m_pBuffer, iLength);

    // Insert new-line after the print-job
    static uint8_t newLineBuf[2] = {'\r', '\n'};
    m_Printer(newLineBuf, 2);
  }
}
